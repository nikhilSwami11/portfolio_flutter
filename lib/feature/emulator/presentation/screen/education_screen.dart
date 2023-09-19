import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/nav_index_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/widget/education_card.dart';
import 'package:portfolio/feature/emulator/presentation/widget/main_app_bar.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        color: AppColors.indigo,
        title: "Education",
        onTap: () {
          context.read<NavIndexCubit>().updateNavIndex(0);
        },
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                spacerH10,
                EducationCard(
                  finalYear: '2022',
                  instituteName: 'The LNM Institute of Information Technology',
                  location: 'Jaipur',
                  marks: '7.31 GPA',
                  degree: "B.Tech",
                  imagePath: AppAssets.lnmiit,
                ),
                spacerH10,
                EducationCard(
                  finalYear: '2017',
                  instituteName: 'Modern Public School',
                  location: 'Bhiwadi',
                  marks: '85%',
                  degree: "12th",
                  imagePath: AppAssets.mps,
                ),
                spacerH10,
                EducationCard(
                  finalYear: '2015',
                  instituteName: 'Modern Public School',
                  location: 'Bhiwadi',
                  marks: '9.6 GPA',
                  degree: '10th',
                  imagePath: AppAssets.mps,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
