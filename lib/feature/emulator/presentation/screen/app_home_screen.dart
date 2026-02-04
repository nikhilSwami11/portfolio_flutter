import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
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
        'icon': Icons.games,
        'iconColor': Colors.green,
        'onTap': () => RouteHelper.push(Routes.snakeGame, context: context),
      },
      {
        'name': 'TicTacToe',
        'icon': Icons.grid_3x3,
        'iconColor': Colors.blue,
        'onTap': () => RouteHelper.push(Routes.ticTacToe, context: context),
      },
      {
        'name': 'Calc',
        'icon': Icons.calculate,
        'iconColor': Colors.orange,
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
        final Color shadowColor =
            isDark ? Colors.black : Colors.white.withOpacity(0.5);

        return Container(
          color: bgColor,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index];
                return NeoPopButton(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  bottomShadowColor: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.2),
                  rightShadowColor: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.2),
                  depth: 5,
                  onTapUp: () {
                    HapticFeedback.vibrate();
                    app['onTap']();
                  },
                  onTapDown: () => HapticFeedback.vibrate(),
                  border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1)),
                  child: Center(
                    child: LocalApps(
                      name: app['name'],
                      // onTap is handled by NeoPopButton
                      iconUrl: app['iconUrl'],
                      icon: app['icon'],
                      iconColor: app['iconColor'],
                      textColor: textColor,
                      shadowColor: shadowColor,
                    ),
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
