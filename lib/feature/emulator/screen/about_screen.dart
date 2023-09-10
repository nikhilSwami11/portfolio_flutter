import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/components/padding.dart';
import 'package:portfolio/core/components/spacers.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/styles/colors.dart';
import 'package:portfolio/core/styles/text_styles.dart';
import 'package:portfolio/feature/emulator/cubit/light_cubit.dart';
import 'package:portfolio/feature/emulator/widget/cat_animation.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> skills = [
      'Flutter',
      'Dart',
      'Unit Testing',
      'Deployment',
      'Bloc',
      'Firebase',
      'Database',
      'OOPS',
      'Isolates',
      'Push Notifications',
      'Maps',
      'Scanner',
      'Payments',
    ];
    final List<String> otherSkills = [
      'Guitar',
      'Stock Market',
      'Magic',
      "Singing",
      "Song writing"
    ];
    return BlocProvider(
      create: (context) => LightCubit(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.black,
          titleSpacing: 0,
          leading: Center(
            child: Image.asset(
              AppAssets.threeDots,
              width: 30,
            ),
          ),
          actions: [
            Padding(
              padding: paddingH10V10,
              child: BlocBuilder<LightCubit, LightState>(
                builder: (context, state) {
                  final Color color = state is LightTurnedOff
                      ? Colors.grey.shade400
                      : Colors.yellowAccent.shade700;
                  final String status = state is LightTurnedOff ? 'OFF' : 'ON';
                  return NeoPopButton(
                      key: UniqueKey(),
                      color: color,
                      onTapUp: () {
                        context.read<LightCubit>().toggleLights();
                        HapticFeedback.vibrate();
                      },
                      onTapDown: () => HapticFeedback.vibrate(),
                      parentColor: Colors.white,
                      child: Padding(
                        padding: paddingH10V4,
                        child: Text(
                          status,
                          style: AppStyles.smTextBoldStyle
                              .copyWith(color: Colors.black),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<LightCubit, LightState>(
          builder: (context, state) {
            if (state is LightTurnedOff) {
              return Image.asset(
                AppAssets.meow,
                width: 50,
                color: Colors.pink,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: paddingH10V10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black)),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        SizedBox(
                            height: 150,
                            child: Image.asset(AppAssets.nikhilProfile)),
                        const Divider(
                          height: 150,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        Flexible(
                          child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: AppColors.indigo,
                                border: const Border.symmetric(
                                    vertical: BorderSide(
                                        width: 2, color: Colors.black)),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "I turn caffeine into beautiful, bug-free apps.",
                                      style: AppStyles.lgTextBoldStyle,
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                spacerH10,
                const Text(
                  "About me??",
                  style: AppStyles.h5TextStyle,
                ),
                const Text(
                  "I am a Mobile Application Developer professionally, Love my job but bugs won't let me sleep.",
                  style: AppStyles.mdTextBoldStyle,
                ),
                spacerH20,
                Container(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What do I know??",
                        style:
                            AppStyles.h5TextStyle.copyWith(color: Colors.white),
                      ),
                      spacerH10,
                      RichText(
                        text: TextSpan(
                          children: List.generate(
                              skills.length,
                              (index) => _buildSpan(
                                  skills[index], AppColors.white, null)),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black)),
                  child: RichText(
                    text: TextSpan(
                      children: List.generate(
                          otherSkills.length,
                          (index) => _buildSpan(otherSkills[index],
                              Colors.black, AppColors.indigo)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                spacerH10,
                const Text(
                  "Experience ??",
                  style: AppStyles.h5TextStyle,
                ),
                const Text(
                  "I have roughly 2 years of experience in flutter, In this short span I have worked on many challenging projects, Don't believe me?? then checkout the Work Tab",
                  style: AppStyles.mdTextBoldStyle,
                ),
                BlocBuilder<LightCubit, LightState>(
                  builder: (context, state) {
                    final Color color = state is LightTurnedOff
                        ? Colors.black
                        : Colors.transparent;
                    return ColoredBox(
                        color: color, child: const CatAnimation());
                  },
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  WidgetSpan _buildSpan(String item, Color borderColor, Color? containerColor) {
    return WidgetSpan(
        child: Container(
      padding: paddingH10V4,
      decoration: BoxDecoration(
          color: containerColor,
          border: Border(
              right: BorderSide(width: 2, color: borderColor),
              bottom: BorderSide(width: 2, color: borderColor),
              left: BorderSide(width: 1, color: borderColor),
              top: BorderSide(width: 1, color: borderColor))),
      child: Text(
        item,
        style: AppStyles.mdTextBoldStyle.copyWith(color: borderColor),
      ),
    ));
  }
}