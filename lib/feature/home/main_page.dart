import 'package:flutter/material.dart';
import 'package:portfolio/core/components/padding.dart';
import 'package:portfolio/core/styles/colors.dart';
import 'package:portfolio/core/styles/text_styles.dart';
import 'package:portfolio/feature/emulator/widget/emulator_widget.dart';

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
              FittedBox(
                child: Text(
                  "Portfolio",
                  style: AppStyles.h1TextStyle.copyWith(
                      fontSize: 90,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                "About the project",
                style: AppStyles.h6TextStyle
                    .copyWith(color: AppColors.white.withOpacity(0.6)),
              ),
              const SizedBox(
                height: 70,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                ),
                child: Text(
                  "The project is a web application created using Flutter. Within this web application, there is another component; hence, it can be described as a device within an application within another device. Inside this device, which is nested within the web application, are various applications, including my portfolio. This concept is inspired by the movie 'Inception,' which featured dreams within dreams. I hope users will enjoy this unique journey.",
                  style: AppStyles.lgTextMediumStyle.copyWith(
                    color: AppColors.white.withOpacity(0.4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Text(
                "Tap on Cat to Start",
                style: AppStyles.lgTextRegularStyle
                    .copyWith(color: AppColors.white.withOpacity(0.4)),
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
                style: AppStyles.h6TextStyle
                    .copyWith(color: AppColors.white.withOpacity(0.6)),
              ),
              Text(
                "Nikhil Swami",
                style: AppStyles.lgTextMediumStyle.copyWith(
                  color: AppColors.white.withOpacity(0.9),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ]),
      ),
    );
  }
}
