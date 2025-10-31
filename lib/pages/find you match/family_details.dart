import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/constants.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/cupertino.dart';

Widget buildFamilyDetails(
  PageController _pageController,
  GlobalKey<FormState> key,
) {
  return Form(
    key: key,

    child: Column(
      children: [
        Text(
          " Family details",
          style: GTextStyle.heading1Bold.copyWith(color: kPrimaryColor),
        ),

        buildNextButton(
          onTap: () {
            if (key.currentState?.validate() ?? false) {
              _pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
        ),
      ],
    ),
  );
}
