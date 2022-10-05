import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nissenger_mobile/modules/greeting/data/cubit/greeting_cubit.dart';
import 'package:nissenger_mobile/modules/greeting/view/components/greeting_actions.dart';
import 'package:nissenger_mobile/modules/greeting/view/components/greeting_title.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4B9BF0),
            Color(0xFF0D5198),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 70.h),
                    child: const GreetingTitle(),
                  ),
                ),
                Flexible(
                  child: Image.asset("assets/images/welcome-image.png"),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.04.sh),
                    child: BlocProvider(
                      create: (_) => GreetingCubit(),
                      child: const GreetingActions(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
