import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/light_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/widget/cat_animation.dart';
import 'package:portfolio/core/cubit/portfolio_cubit.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LightCubit(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          elevation: 0,
          backgroundColor: Colors.black,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              "Nikhil Swami",
              style: AppStyles.h6TextStyle
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          centerTitle: false,
          leading: NeoPopButton(
            color: AppColors.indigo,
            onTapUp: () {
              RouteHelper.pop(context: context);
            },
            onTapDown: () => HapticFeedback.vibrate(),
            parentColor: Colors.transparent,
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
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
        body: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, portfolioState) {
            if (portfolioState is PortfolioLoaded) {
              final about = portfolioState.portfolioData.about;
              return ScrollConfiguration(
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
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: BlocBuilder<LightCubit, LightState>(
                                    builder: (context, state) {
                                      final List<Color> colors =
                                          (state is LightTurnedOff)
                                              ? [
                                                  Colors.black.withOpacity(0.4),
                                                  Colors.black.withOpacity(0.5)
                                                ]
                                              : [
                                                  Colors.transparent,
                                                  Colors.transparent
                                                ];
                                      return ShaderMask(
                                        shaderCallback: (bounds) {
                                          return LinearGradient(colors: colors)
                                              .createShader(bounds);
                                        },
                                        child: Image.asset(about.profileImage),
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              about.tagline,
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
                        Text(
                          about.descriptionTitle,
                          style: AppStyles.h5TextStyle,
                        ),
                        Text(
                          about.description,
                          style: AppStyles.mdTextBoldStyle,
                        ),
                        spacerH20,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "What do I know?",
                                style: AppStyles.h6TextStyle
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  'Mobile Architecture',
                                  'Agentic AI & LLMs',
                                  'Distributed Backend',
                                  'Applied Machine Learning'
                                ]
                                    .map((skill) => _buildSpan(
                                        skill,
                                        AppColors.indigo,
                                        Colors.white,
                                        AppColors.black))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        spacerH20,
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2, color: Colors.black)),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "hobbies",
                                style: AppStyles.h6TextStyle,
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: List.generate(
                                    (about.otherSkills ?? []).length,
                                    (index) => _buildSpan(
                                        (about.otherSkills ?? [])[index],
                                        AppColors.black,
                                        AppColors.black,
                                        AppColors.indigo)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        spacerH10,
                        Text(
                          about.experienceTitle,
                          style: AppStyles.h5TextStyle,
                        ),
                        Text(
                          about.experienceSummary,
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
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildSpan(
      String item, Color borderColor, Color? textColor, Color? containerColor) {
    return Container(
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
        style: AppStyles.mdTextBoldStyle.copyWith(color: textColor),
      ),
    );
  }
}
