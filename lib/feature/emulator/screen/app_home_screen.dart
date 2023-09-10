import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/components/padding.dart';
import 'package:portfolio/core/components/spacers.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/navigation/routes.dart';
import 'package:portfolio/feature/emulator/cubit/settings_manager_cubit.dart';
import 'package:portfolio/feature/emulator/screen/settings_screen.dart';
import 'package:portfolio/feature/emulator/widget/local_apps.dart';

class AppHomeScreen extends StatelessWidget {
  const AppHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _settingsCubit = context.read<SettingsManagerCubit>();
    return Stack(
      children: [
        Padding(
          padding: paddingH10V10,
          child: Row(
            children: [
              LocalApps(
                name: 'Nikhil',
                onTap: () {
                  RouteHelper.push(Routes.nikhilHome, context: context);
                },
                iconUrl: AppAssets.nikhil,
              ),
              spacerW10,
              LocalApps(
                name: 'Settings',
                onTap: () {
                  RouteHelper.pushScreen(
                      BlocProvider.value(
                        value: _settingsCubit,
                        child: const SettingsScreen(),
                      ),
                      context: context);
                },
                iconUrl: AppAssets.settings,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
