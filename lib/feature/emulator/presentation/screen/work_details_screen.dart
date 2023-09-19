import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/data/work_details_banner_model.dart';
import 'package:portfolio/feature/emulator/presentation/widget/main_app_bar.dart';

class WorkDetailsScreen extends StatelessWidget {
  final String companyName;
  final Color backGroundColor;
  final String responsibilityDescription;
  // final List<String> skills;
  final List<WorkDetailsBanner> workDetailsBanner;
  const WorkDetailsScreen(
      {super.key,
      required this.companyName,
      required this.backGroundColor,
      required this.responsibilityDescription,
      // required this.skills,
      required this.workDetailsBanner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: MainAppBar(
        color: backGroundColor,
        title: companyName,
      ),
      body: Padding(
        padding: paddingH10V10,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Responsibilities",
            style: AppStyles.h5TextStyle,
          ),
          spacerH10,
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => spacerH15,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Container(
                  padding: paddingH8V8,
                  decoration: BoxDecoration(
                      color: index % 2 == 0 ? AppColors.black : AppColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      border: Border.all(width: 1, color: AppColors.black)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workDetailsBanner[index].title,
                        style: AppStyles.lgTextBoldStyle.copyWith(
                            color: index % 2 == 0
                                ? AppColors.white
                                : AppColors.black),
                      ),
                      spacerH10,
                      Text(
                        workDetailsBanner[index].subtitle,
                        style: AppStyles.smTextBoldStyle.copyWith(
                            color: index % 2 == 0
                                ? AppColors.white
                                : AppColors.black),
                      ),
                    ],
                  ),
                ),
                itemCount: workDetailsBanner.length,
              ),
            ),
          ),
          // spacerH20,
          // const Text(
          //   StringConstants.skills,
          //   style: AppStyles.h5TextStyle,
          // ),
          // spacerH10,
          // GridView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: skills.length,
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       childAspectRatio: 2.5,
          //       crossAxisCount: 3,
          //       crossAxisSpacing: 2,
          //       mainAxisSpacing: 1),
          //   itemBuilder: (BuildContext context, int index) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         borderRadius: const BorderRadius.all(Radius.circular(4)),
          //         color: index % 2 == 0 ? Colors.white : Colors.black,
          //       ),
          //       child: Center(
          //         child: Text(
          //           skills[index],
          //           style: AppStyles.smTextMediumStyle.copyWith(
          //               color: index % 2 == 0 ? Colors.black : Colors.white),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ]),
      ),
    );
  }
}
