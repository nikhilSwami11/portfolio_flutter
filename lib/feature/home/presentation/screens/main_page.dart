import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/widget/emulator_widget.dart';
import 'package:portfolio/feature/home/presentation/widgets/social_links.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: paddingH10V4,
                child: FittedBox(
                  child: Text(
                    "Portfolio",
                    style: AppStyles.h1TextStyle.copyWith(
                        fontSize: 90,
                        color: AppColors.whiteOp9,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "About the project",
                style: AppStyles.h6TextStyle.copyWith(
                  color: AppColors.whiteOp6,
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: paddingH10V4,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                  ),
                  child: Text(
                    "This project is an innovative web application made in Flutter, inspired by my daily development journey. I've captured the essence of running applications on virtual devices to create a unique user experience. I hope users will enjoy this unique journey.",
                    style: AppStyles.lgTextMediumStyle.copyWith(
                      color: AppColors.whiteOp4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Text(
                "Tap on Cat to Start",
                style: AppStyles.lgTextRegularStyle.copyWith(
                  color: AppColors.whiteOp4,
                ),
              ),
              const Padding(
                padding: paddingH16V16,
                child: Emulator(),
              ),
              const SizedBox(
                height: 90,
              ),
              Text(
                "Created By:",
                style: AppStyles.h6TextStyle.copyWith(
                  color: AppColors.whiteOp6,
                ),
              ),
              Text(
                "Nikhil Swami",
                style: AppStyles.lgTextMediumStyle.copyWith(
                  color: AppColors.whiteOp9,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const SocialLinksWidget(),
              const SizedBox(
                height: 20,
              ),
            ]),
      ),
    );
  }
}
