import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constants/globals.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/nav_index_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/screen/about_screen.dart';
import 'package:portfolio/feature/emulator/presentation/screen/education_screen.dart';
import 'package:portfolio/feature/emulator/presentation/screen/experience_screen.dart';
import 'package:portfolio/feature/emulator/presentation/widget/bottom_navigation_widget.dart';

class NikhilHomeScreen extends StatefulWidget {
  const NikhilHomeScreen({super.key});

  @override
  State<NikhilHomeScreen> createState() => _NikhilHomeScreenState();
}

class _NikhilHomeScreenState extends State<NikhilHomeScreen> {
  late List<Widget> _tabs;

  final _navCubit = NavIndexCubit();

  @override
  void initState() {
    Globals.isBackDisabled = false;
    _tabs = const [
      AboutScreen(),
      ExperienceScreen(),
      EducationScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _navCubit,
      child: Scaffold(
          bottomNavigationBar: const BottomNavigationWidget(),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            children: _tabs,
            controller: _navCubit.pageController,
          )),
    );
  }

  @override
  void dispose() {
    Globals.isBackDisabled = true;
    super.dispose();
  }
}
