import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/plain_data/teachers_list.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/types/teacher.dart';
import 'package:nissenger_mobile/modules/teachers_search/view/components/dot_divider.dart';

class TeachersListView extends StatefulWidget {
  final Function({
    required String firstNameTeacher,
    required String secondNameTeacher,
    required String thirdNameTeacher,
  }) onChanged;

  const TeachersListView({
    required this.onChanged,
    super.key,
  });

  @override
  State<TeachersListView> createState() => _TeachersListViewState();
}

class _TeachersListViewState extends State<TeachersListView> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String query = "";

    String activeFirstName = "";
    String activeSecondName = "";
    String activeThirdName = "";

    List<Teacher> matchQuery = [];

    if (query.isNotEmpty) {
      for (var teacher in teachersList) {
        String teacherFullName =
            "${teacher.firstName} ${teacher.secondName} ${teacher.thirdName}";
        if (teacherFullName.toLowerCase().contains(query.toLowerCase())) {
          matchQuery.add(teacher);
        }
      }
    } else {
      () => matchQuery = teachersList;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchTextField(
            fieldValue: (String value) {
              setState(() {
                query = value;
              });
            },
          ),
        ),
        ListView.separated(
          separatorBuilder: (context, index) {
            return const DotDivider();
          },
          itemCount: matchQuery.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (() {
                setState(() {
                  activeFirstName = matchQuery[index].firstName;
                  activeSecondName = matchQuery[index].secondName;
                  activeThirdName = matchQuery[index].thirdName;
                  widget.onChanged(
                    firstNameTeacher: activeFirstName,
                    secondNameTeacher: activeSecondName,
                    thirdNameTeacher: activeThirdName,
                  );
                });
              }),
              child: ListTile(
                title: Text(
                  activeFirstName + activeSecondName + activeThirdName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontSize: 14.sp,
                    color: activeFirstName == matchQuery[index].firstName &&
                            activeSecondName == matchQuery[index].secondName &&
                            activeThirdName == matchQuery[index].thirdName
                        ? theme.colorScheme.primary
                        : theme.colorScheme.secondary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.fieldValue,
  });

  final ValueChanged<String> fieldValue;

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      onChanged: (String value) {
        fieldValue(value);
      },
      onSubmitted: (String value) {
        fieldValue(value);
      },
    );
  }
}
