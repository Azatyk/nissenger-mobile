import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/teachers_search/data/plain_data/teachers_list.dart';
import 'package:nissenger_mobile/common/components/dashed_divider.dart';

class TeachersListView extends StatefulWidget {
  final Function({
    required String teacherFullName,
  }) onChanged;

  const TeachersListView({
    required this.onChanged,
    super.key,
  });

  @override
  State<TeachersListView> createState() => _TeachersListViewState();
}

class _TeachersListViewState extends State<TeachersListView> {
  String query = "";
  String activeTeacherName = "";
  List<String> matchQuery = [];

  void updateMatchQueryList() {
    if (query.isNotEmpty) {
      matchQuery = [];

      for (var teacher in teachersList) {
        if (teacher.toLowerCase().contains(query.toLowerCase())) {
          setState(() {
            matchQuery.add(teacher);
          });
        }
      }
    } else {
      matchQuery = teachersList;
    }
  }

  @override
  void initState() {
    updateMatchQueryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: SearchTextField(
            fieldValue: (String value) {
              query = value;
              updateMatchQueryList();
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return const DashedDivider();
            },
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (() {
                  setState(() {
                    activeTeacherName = matchQuery[index];
                  });

                  widget.onChanged(
                    teacherFullName: activeTeacherName,
                  );
                }),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h),
                  child: Text(
                    matchQuery[index],
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 14.sp,
                      color: activeTeacherName == matchQuery[index]
                          ? theme.colorScheme.primary
                          : theme.colorScheme.secondary,
                    ),
                  ),
                ),
              );
            },
          ),
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
      placeholder: "Поиск...",
      placeholderStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 12.sp,
          ),
      onChanged: (String value) {
        fieldValue(value);
      },
      onSubmitted: (String value) {
        fieldValue(value);
      },
    );
  }
}
