import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/navigation/routes.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/settings_manager_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/screen/settings_screen.dart';
import 'package:portfolio/feature/emulator/presentation/widget/local_apps.dart';

class AppHomeScreen extends StatelessWidget {
  const AppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _settingsCubit = context.read<SettingsManagerCubit>();

    final List<Map<String, dynamic>> apps = [
      {
        'name': 'Portfolio',
        'iconUrl': AppAssets.nikhil,
        'onTap': () => RouteHelper.push(Routes.nikhilHome, context: context),
      },
      {
        'name': 'Snake',
        'iconUrl': AppAssets.snakeIcon,
        'onTap': () => RouteHelper.push(Routes.snakeGame, context: context),
      },
      {
        'name': 'TicTacToe',
        'iconUrl': AppAssets.tictactoeIcon,
        'onTap': () => RouteHelper.push(Routes.ticTacToe, context: context),
      },
      {
        'name': 'Calc',
        'iconUrl': AppAssets.calculatorIcon,
        'onTap': () => RouteHelper.push(Routes.calculator, context: context),
      },
      {
        'name': 'Settings',
        'iconUrl': AppAssets.settings,
        'onTap': () => RouteHelper.pushScreen(
            BlocProvider.value(
              value: _settingsCubit,
              child: const SettingsScreen(),
            ),
            context: context),
      },
    ];

    return BlocBuilder<SettingsManagerCubit, SettingsManagerState>(
      builder: (context, state) {
        // Default to white if transparent (as per user request)
        Color bgColor = context.read<SettingsManagerCubit>().selectedColor;
        if (bgColor == Colors.transparent) {
          bgColor = Colors.white;
        }

        // Determine brightness to set text color
        final bool isDark =
            ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark;
        final Color textColor = isDark ? Colors.white : Colors.black;

        return Container(
          color: bgColor,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 20),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 24,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.vibrate();
                    app['onTap']();
                  },
                  child: LocalApps(
                    name: app['name'],
                    iconUrl: app['iconUrl'],
                    icon: app['icon'],
                    iconColor: app['iconColor'],
                    textColor: textColor,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
