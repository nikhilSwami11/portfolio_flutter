import 'package:flutter/material.dart';

class InternalRoutingWidget extends StatelessWidget {
  const InternalRoutingWidget({
    super.key,
    required this.navigatorKey,
    required this.onGenerateRoute,
    required this.initialRoute,
  });
  final GlobalKey<NavigatorState> navigatorKey;
  final Route<dynamic>? Function(RouteSettings) onGenerateRoute;
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: navigatorKey,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
