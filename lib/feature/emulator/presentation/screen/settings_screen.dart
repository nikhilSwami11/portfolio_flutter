import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/constants/globals.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/settings_manager_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/widget/switch_toggle.dart';
import 'package:portfolio/feature/emulator/presentation/widget/tool_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<Color> colors = [
    Colors.transparent,
    AppColors.blueShade100,
    AppColors.indigo,
    AppColors.redShade100,
    AppColors.greenShade100,
    AppColors.tealShade100,
    AppColors.nowFloatsColor
  ];
  final List<String> colorsString = [
    "transparent",
    "blue",
    "indigo",
    "red",
    "green",
    "teal",
    "yellow"
  ];

  @override
  void initState() {
    Globals.isBackDisabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsManagerCubit, SettingsManagerState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.read<SettingsManagerCubit>().selectedColor,
          body: Column(
            children: [
              const ToolBar(),
              spacerH10,
              const Text(
                "Background Color Settings",
                style: AppStyles.h6TextStyle,
              ),
              spacerH10,
              Padding(
                padding: paddingH10V10,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: colors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.5,
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => {
                        context
                            .read<SettingsManagerCubit>()
                            .changeColor(index, colors[index])
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1,
                              color: AppColors.black,
                            )),
                        child: Center(
                          child: Text(
                            colorsString[index],
                            style: AppStyles.mdTextBoldStyle
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              spacerH20,
              const Text(
                "Display as AM/PM",
                style: AppStyles.h6TextStyle,
              ),
              SwitchToggle(
                  isAmPm: context.read<SettingsManagerCubit>().isAmPm,
                  onTap: (bool value) {
                    context
                        .read<SettingsManagerCubit>()
                        .changeAmPmFormat(value);
                  })
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Globals.isBackDisabled = true;
    super.dispose();
  }
}
