import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/cubit/portfolio_cubit.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/navigation/routes.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/nav_index_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/widget/company_cards.dart';
import 'package:portfolio/feature/emulator/presentation/widget/main_app_bar.dart';

class ExperienceScreen extends StatelessWidget {
  const ExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        color: AppColors.indigo,
        title: "Work Experience",
        onTap: () {
          context.read<NavIndexCubit>().updateNavIndex(0);
        },
      ),
      body: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if (state is PortfolioLoaded) {
            final experiences = state.portfolioData.experiences;
            return Padding(
              padding: paddingH10V10,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: experiences.map((experience) {
                    final color = Color(int.parse(experience.backgroundColorHex
                        .replaceFirst('#', '0xFF')));
                    return Column(
                      children: [
                        NeoPopButton(
                          color: Colors.white,
                          onTapUp: () {
                            HapticFeedback.vibrate();
                            RouteHelper.push(Routes.workDetails,
                                context: context,
                                args: {
                                  'backGroundColor': color,
                                  'companyName': experience.companyName,
                                  'responsibilityDescription':
                                      '', // Pass empty or retrieve if available in future
                                  'workDetailsBanner':
                                      experience.detailBannerData,
                                });
                          },
                          onTapDown: () => HapticFeedback.vibrate(),
                          parentColor: Colors.transparent,
                          child: CompanyCards(
                            backgroundColor: color,
                            companyName: experience.companyName,
                            companySite: experience.siteUrl,
                            duration: experience.duration,
                            title: experience.role,
                            location: experience.location,
                            imageIcon: experience.logoAsset,
                            jobDescription: experience.summary,
                            appName: experience.appName,
                            appDownloads: experience.appDownloads,
                          ),
                        ),
                        spacerH10,
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
