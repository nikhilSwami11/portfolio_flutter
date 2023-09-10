import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/constant.dart';
import 'package:portfolio/feature/home/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nikhil\'s Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, fontFamily: Constant.TURRET_ROAD),
      home: const MainPage(),
    );
  }
}
