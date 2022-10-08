import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/common/components/common_header.dart';
import 'package:nissenger_mobile/modules/grade_choice/view/components/grade_choice_slider.dart';

class GradeChoicePage extends StatefulWidget {
  const GradeChoicePage({Key? key}) : super(key: key);

  @override
  State<GradeChoicePage> createState() => _GradeChoicePageState();
}

class _GradeChoicePageState extends State<GradeChoicePage> {
  double gradeNumberSliderValue = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 27.w,
            vertical: 30.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(
                title: "Выбор класса",
                onBackButtonPressed: () {},
              ),
              SizedBox(height: 40.h),
              GradeChoiceSlider(
                  value: gradeNumberSliderValue,
                  min: 7,
                  max: 12,
                  divisions: 5,
                  onChanged: (double value) {
                    setState(() {
                      gradeNumberSliderValue = value;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
