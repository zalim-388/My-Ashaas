import 'package:agent_porta/pages/find%20you%20match/find_you_matchCreation.dart';
import 'package:agent_porta/styles/style.dart';
import 'package:flutter/cupertino.dart';

Widget buildEducationProfessionalDetails(
  PageController _pageController,
  GlobalKey<FormState> key,
) {
  return Form(
    key: key,

    child: Column(
      children: [
        Text(
          "Education & Professional Details",
          style: GTextStyle.heading1Bold,
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
