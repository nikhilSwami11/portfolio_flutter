import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/settings_manager_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/screen/app_home_screen.dart';
import 'package:portfolio/feature/emulator/presentation/widget/tool_bar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SettingsManagerCubit(),
        child: BlocBuilder<SettingsManagerCubit, SettingsManagerState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor:
                  context.read<SettingsManagerCubit>().selectedColor,
              body: const Column(
                children: [ToolBar(), AppHomeScreen()],
              ),
            );
          },
        ));
  }
}
