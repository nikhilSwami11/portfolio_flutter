import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/components/padding.dart';
import 'package:portfolio/core/components/spacers.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/constants/string_constants.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/navigation/routes.dart';
import 'package:portfolio/core/styles/colors.dart';
import 'package:portfolio/feature/emulator/cubit/nav_index_cubit.dart';
import 'package:portfolio/feature/emulator/widget/company_cards.dart';
import 'package:portfolio/feature/emulator/widget/main_app_bar.dart';

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
      body: Padding(
        padding: paddingH10V10,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeoPopButton(
                color: Colors.white,
                onTapUp: () {
                  HapticFeedback.vibrate();
                  RouteHelper.push(Routes.workDetails, context: context, args: {
                    'backGroundColor': AppColors.nowFloatsColor,
                    'companyName': StringConstants.nowFloats,
                    'responsibilityDescription':
                        StringConstants.nowFloatsResponsibility,
                    'skills': [
                      'Flutter',
                      'Dart',
                      'Bloc',
                      'Firebase',
                      'Local DB',
                      'Floor',
                      'Isolated',
                      'Work Manager',
                      'Flavor setup',
                      'Notifications',
                      'Dynamic Links',
                      'Maps',
                      'Scanner',
                      'Payments',
                    ],
                  });
                },
                onTapDown: () => HapticFeedback.vibrate(),
                parentColor: Colors.transparent,
                child: CompanyCards(
                  backgroundColor: Colors.yellowAccent.shade100,
                  companyName: "Nowfloats",
                  companySite: 'nowfloats.com',
                  duration: 'jan 2023 - current',
                  title: "Flutter Developer",
                  location: "Hyderabad",
                  imageIcon: AppAssets.nowFloatsLogo,
                  jobDescription:
                      'Nowfloats is reliance child company, that delivers SAAS products, working as a SDE',
                ),
              ),
              spacerH10,
              NeoPopButton(
                color: Colors.white,
                onTapUp: () {
                  HapticFeedback.vibrate();
                  RouteHelper.push(Routes.workDetails, context: context, args: {
                    'backGroundColor': AppColors.fraazoColor,
                    'companyName': StringConstants.fraazo,
                    'responsibilityDescription':
                        StringConstants.fraazoResponsibility,
                    'skills': [
                      'Flutter',
                      'Dart',
                      'Riverpod',
                      'Firebase',
                      'Testing',
                      'Maps',
                      'Web Sockets',
                      'SDUI',
                      'Streams'
                    ],
                  });
                },
                onTapDown: () => HapticFeedback.vibrate(),
                parentColor: Colors.transparent,
                child: CompanyCards(
                  backgroundColor: Colors.greenAccent.shade100,
                  companyName: "Fraazo",
                  companySite: 'fraazo.com',
                  duration: 'jan 2022 - sept 2022',
                  title: "Flutter Developer",
                  location: "Mumbai",
                  imageIcon: AppAssets.fraazoLogo,
                  jobDescription:
                      'Fraazo is a quick-commerce startup that sells fruits and vegetables online. Worked as an SDE intern for 6 month, then SDE',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
