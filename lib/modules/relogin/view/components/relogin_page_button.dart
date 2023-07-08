import "package:flutter/material.dart";
import 'package:nissenger_mobile/common/components/common_button.dart';
import 'package:nissenger_mobile/helpers/lang_keys.dart';
import 'package:nissenger_mobile/modules/greeting/view/pages/greeting_page.dart';

class ReloginPageButton extends StatelessWidget {
  const ReloginPageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      text: LangKeys.reloginButton.translate(context),
      reverse: true,
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const GreetingPage(),
          ),
          (route) => false,
        );
      },
    );
  }
}
