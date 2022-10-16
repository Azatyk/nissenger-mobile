import 'package:flutter/material.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/plain_data/teachers_list.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var teacher in TeachersList) {
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

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var teacher in TeachersList) {
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
