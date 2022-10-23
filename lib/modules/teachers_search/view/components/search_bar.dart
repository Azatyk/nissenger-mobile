import 'package:flutter/material.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/plain_data/teachers_list.dart';
import 'package:nissenger_mobile/modules/teachers_search/view/components/dot_divider.dart';

class SearchBar extends StatefulWidget {
  final Function({
    required String teacherFullName,
  }) onChanged;

  const SearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String teacherNameValue = "";

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(
            function: ({required String teacherFullName}) {
              setState(() {
                teacherNameValue = teacherFullName;
                widget.onChanged(teacherFullName: teacherNameValue);
              });
            },
          ),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final Function ({
  required String teacherFullName,}) function;

  CustomSearchDelegate({required this.function});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var teacher in teachersList) {
      String teacherFullName =
          "${teacher.firstName} ${teacher.secondName} ${teacher.thirdName}";
      if (teacherFullName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(teacherFullName);
      }
    }
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const DotDivider();
      },
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: function(teacherFullName: result),
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var teacher in teachersList) {
      String teacherFullName =
          "${teacher.firstName} ${teacher.secondName} ${teacher.thirdName}";
      if (teacherFullName.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(teacherFullName);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
