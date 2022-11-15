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
    ThemeData theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.primary,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 27.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 65.h),
                  child: const GreetingTitle(),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Align(
                    child: Image.asset(
                      "assets/images/welcome-image.png",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 0.04.sh),
                  child: BlocProvider(
                    create: (_) => GreetingCubit(),
                    child: const GreetingActions(),
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
