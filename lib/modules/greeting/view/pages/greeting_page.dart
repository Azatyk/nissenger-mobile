import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nissenger_mobile/modules/greeting/data/bloc/greeting_bloc.dart';
import 'package:nissenger_mobile/modules/greeting/data/bloc/greeting_event.dart';
import 'package:nissenger_mobile/modules/greeting/data/types/user_types.dart';
import 'package:nissenger_mobile/modules/greeting/view/components/greeting_actions.dart';
import 'package:nissenger_mobile/modules/greeting/view/components/greeting_title.dart';

class GreetingPage extends StatelessWidget {
  const GreetingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: size.height * 0.06),
                    child: const GreetingTitle(),
                  ),
                ),
                Flexible(
                  child: Image.asset("assets/images/welcome-image.png"),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: BlocProvider(
                      create: (_) => GreetingBloc()
                        ..add(UserTypeChosen(userType: UserTypes.teacher)),
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
