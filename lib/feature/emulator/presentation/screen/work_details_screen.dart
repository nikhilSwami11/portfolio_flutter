import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/constants/string_constants.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/widget/main_app_bar.dart';

class WorkDetailsScreen extends StatelessWidget {
  final String companyName;
  final Color backGroundColor;
  final String responsibilityDescription;
  final List<String> skills;
  const WorkDetailsScreen(
      {super.key,
      required this.companyName,
      required this.backGroundColor,
      required this.responsibilityDescription,
      required this.skills});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: MainAppBar(
        color: backGroundColor,
        title: companyName,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingH10V10,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Responsibility",
              style: AppStyles.h6TextStyle,
            ),
            Text(
              responsibilityDescription,
              style: AppStyles.smTextBoldStyle,
            ),
            spacerH10,
            const Text(
              StringConstants.skillsAndThirdParty,
              style: AppStyles.h6TextStyle,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2,
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 1),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: index % 2 == 0 ? Colors.white : Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      skills[index],
                      style: AppStyles.smTextMediumStyle.copyWith(
                          color: index % 2 == 0 ? Colors.black : Colors.white),
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
