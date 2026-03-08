import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constants/constant.dart';
import 'package:portfolio/core/cubit/portfolio_cubit.dart';
import 'package:portfolio/core/repository/portfolio_repository.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/settings_manager_cubit.dart';
import 'package:portfolio/feature/home/presentation/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PortfolioRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PortfolioCubit(
              repository: context.read<PortfolioRepository>(),
            )..loadPortfolioData(),
          ),
          BlocProvider(
            create: (context) => SettingsManagerCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Nikhil\'s Portfolio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: Constant.COURIER),
          home: const MainPage(),
        ),
      ),
    );
  }
}
