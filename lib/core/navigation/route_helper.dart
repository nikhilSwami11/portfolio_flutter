import 'package:flutter/material.dart';
import 'package:portfolio/core/navigation/route_arguments.dart';

mixin RouteHelper {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static BuildContext get navigatorContext => navigatorKey.currentContext!;
  static final GlobalKey<NavigatorState> mobileNavigatorKey =
      GlobalKey<NavigatorState>();
  static BuildContext get mobileNavigatorContext =>
      mobileNavigatorKey.currentContext!;
  static final GlobalKey<NavigatorState> appsNavigatorKey =
      GlobalKey<NavigatorState>();
  static BuildContext get appNavigatorContext =>
      appsNavigatorKey.currentContext!;
  static Future<Object?> push(
    String routeName, {
    Object? args,
    RouteAnimationType? animation,
    BuildContext? context,
  }) {
    return Navigator.of(context ?? navigatorContext).pushNamed(routeName,
        arguments: RouteArguments(
          args,
          animation: animation,
        ));
  }

  static Future<Object?> pushScreen(Widget widget, {BuildContext? context}) {
    return Navigator.of(context ?? navigatorContext).push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  static Future<Object?> pushReplacement(
    String routeName, {
    Object? args,
    RouteAnimationType? animation,
    BuildContext? context,
  }) {
    return Navigator.of(context ?? navigatorContext).pushReplacementNamed(
      routeName,
      arguments: RouteArguments(
        args,
        animation: animation,
      ),
    );
  }

  static Future<Object?> pushAndPopUntil(
    String routeName, {
    String? popUntilRouteName,
    Object? args,
    RouteAnimationType? animation,
    BuildContext? context,
  }) {
    return Navigator.of(context ?? navigatorContext).pushNamedAndRemoveUntil(
      routeName,
      popUntilRouteName != null
          ? ModalRoute.withName(popUntilRouteName)
          : (Route<dynamic> route) => false,
      arguments: RouteArguments(args, animation: animation),
    );
  }

  static void pop({dynamic args, BuildContext? context}) {
    return Navigator.of(context ?? navigatorContext).pop(args);
  }

  static bool canPop() {
    return Navigator.of(navigatorContext).canPop();
  }

  static Future<bool> maybePop() {
    return Navigator.of(navigatorContext).maybePop();
  }

  static void popUntil(String routesName, {BuildContext? context}) {
    Navigator.of(context ?? navigatorContext)
        .popUntil(ModalRoute.withName(routesName));
  }

  static void popUntilCount({required int count}) {
    int n = 0;
    Navigator.of(navigatorContext).popUntil((_) => n++ >= count);
  }

  static Future<T?> openDialog<T>(
    Widget child, {
    bool isDismissible = true,
    BuildContext? context,
    Color barrierColor = Colors.black26,
  }) {
    return showDialog<T?>(
      context: context ?? navigatorContext,
      builder: (_) => child,
      barrierDismissible: isDismissible,
      barrierColor: barrierColor,
    );
  }

  static Future<T?> openModalSheet<T>(
    Widget child, {
    double cornerRadius = 16,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return showModalBottomSheet<T?>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(cornerRadius),
          topRight: Radius.circular(cornerRadius),
        )),
        context: navigatorContext,
        builder: (_) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(navigatorContext).viewInsets.bottom),
              child: child,
            ),
        isDismissible: isDismissible,
        backgroundColor: Colors.white,
        isScrollControlled: true,
        enableDrag: enableDrag);
  }
}
