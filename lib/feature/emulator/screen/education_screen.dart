import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/components/spacers.dart';
import 'package:portfolio/core/styles/colors.dart';
import 'package:portfolio/feature/emulator/cubit/nav_index_cubit.dart';
import 'package:portfolio/feature/emulator/widget/education_card.dart';
import 'package:portfolio/feature/emulator/widget/main_app_bar.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              spacerH10,
              NeoPopButton(
                  color: Colors.white,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  parentColor: Colors.transparent,
                  child: const EducationCard(
                    finalYear: '2022',
                    instituteName:
                        'The LNM Institute of Information Technology',
                    location: 'Jaipur',
                    marks: '7.31 GPA',
                    degree: "B.Tech",
                  )),
              spacerH10,
              NeoPopButton(
                  color: Colors.white,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  parentColor: Colors.transparent,
                  child: const EducationCard(
                    finalYear: '2017',
                    instituteName: 'Modern Public School',
                    location: 'Bhiwadi',
                    marks: '85%',
                    degree: "12th",
                  )),
              spacerH10,
              NeoPopButton(
                  color: Colors.white,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  parentColor: Colors.transparent,
                  child: const EducationCard(
                    finalYear: '2015',
                    instituteName: 'Modern Public School',
                    location: 'Bhiwadi',
                    marks: '9.6 GPA',
                    degree: '10th',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
