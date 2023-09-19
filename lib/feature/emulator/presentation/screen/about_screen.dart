import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/constants/constant.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/light_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/widget/cat_animation.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> skills = Constant.skills;
    const List<String> otherSkills = Constant.otherSkills;
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
                        child: Row(
                          children: [
                            Text(
                              status,
                              style: AppStyles.smTextBoldStyle
                                  .copyWith(color: Colors.black),
                            ),
                          ],
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
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: SingleChildScrollView(
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
                            child: BlocBuilder<LightCubit, LightState>(
                              builder: (context, state) {
                                final List<Color> colors = (state
                                        is LightTurnedOff)
                                    ? [
                                        Colors.black.withOpacity(0.4),
                                        Colors.black.withOpacity(0.5)
                                      ]
                                    : [Colors.transparent, Colors.transparent];
                                return ShaderMask(
                                  shaderCallback: (bounds) {
                                    return LinearGradient(colors: colors)
                                        .createShader(bounds);
                                  },
                                  child: Image.asset(AppAssets.nikhilProfile),
                                  blendMode: BlendMode.darken,
                                );
                              },
                            ),
                          ),
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
                    "I'm a passionate Mobile Developer with a knack for turning code into amazing apps. Let's create something great together!",
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
                          style: AppStyles.h5TextStyle
                              .copyWith(color: Colors.white),
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
                    "I have 2 years of experience in flutter, In this short span I have worked on many challenging projects, and would do so in the future",
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
