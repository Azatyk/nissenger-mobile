import 'package:flutter/material.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/plain_data/teachers_list.dart';
import 'package:nissenger_mobile/modules/teachers_search/view/components/dot_divider.dart';

class TeachersListView extends StatefulWidget {
  const TeachersListView({super.key});

  @override
  State<TeachersListView> createState() => _TeachersListViewState();
}

class _TeachersListViewState extends State<TeachersListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const DotDivider();
      },
      itemCount: teachersList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: ListTile(
            title: Text(teachersList[index].firstName + teachersList[index].secondName + teachersList[index].thirdName),
          ),
        );
      },
    );
  }
}