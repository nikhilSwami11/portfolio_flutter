import 'package:flutter/material.dart';
import 'package:portfolio/core/navigation/animation_generator.dart';
import 'package:portfolio/core/navigation/route_arguments.dart';
import 'package:portfolio/core/navigation/routes.dart';
import 'package:portfolio/feature/emulator/presentation/screen/onboarding_screen.dart';
import 'package:portfolio/feature/emulator/presentation/screen/work_details_screen.dart';
import 'package:portfolio/feature/emulator/presentation/screen/landing_page.dart';
import 'package:portfolio/feature/emulator/presentation/screen/nikhil_home_screen.dart';

class MobileRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? routeName = settings.name;
    final RouteArguments? screenArguments =
        settings.arguments as RouteArguments?;
    final animationType = screenArguments?.animation;
    final Widget widget;
    switch (routeName) {
      case Routes.onboarding:
        widget = const OnboardingScreen();
        break;
      case Routes.landing:
        widget = const LandingPage();
        break;
      case Routes.nikhilHome:
        widget = const NikhilHomeScreen();
        break;
      case Routes.workDetails:
        final args = screenArguments?.arguments as Map<String, dynamic>;
        widget = WorkDetailsScreen(
          backGroundColor: args['backGroundColor'],
          companyName: args['companyName'],
          responsibilityDescription: args['responsibilityDescription'],
          // skills: args['skills'],
          workDetailsBanner: args['workDetailsBanner'],
        );
        break;
      default:
        widget = const LandingPage();
        break;
    }
    switch (animationType) {
      case RouteAnimationType.slideLeft:
        return SlideLeftRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.slideRight:
        return SlideRightRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.slideTop:
        return SlideTopRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.slideBottom:
        return SlideBottomRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.zoomOut:
        return ZoomOutRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.zoomOutAndFade:
        return ZoomOutAndFadeRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      case RouteAnimationType.fade:
        return FadeRouteBuilder(
          widget: widget,
          routeSettings: RouteSettings(name: routeName),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => widget,
          settings: RouteSettings(name: routeName),
        );
    }
  }
}
