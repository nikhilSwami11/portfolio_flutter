import 'package:flutter/material.dart';
import 'package:portfolio/feature/emulator/presentation/widget/tool_bar.dart';

class InternalRoutingWidget extends StatefulWidget {
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
  State<InternalRoutingWidget> createState() => _InternalRoutingWidgetState();
}

class _InternalRoutingWidgetState extends State<InternalRoutingWidget> {
  bool _showToolBar = false;
  bool _pendingShow = false;
  late final _routeObserver = _ToolBarRouteObserver(
    onRouteChanged: (routeName) {
      _pendingShow = routeName != '/onboarding';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _showToolBar != _pendingShow) {
          setState(() => _showToolBar = _pendingShow);
        }
      });
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          if (_showToolBar) const ToolBar(),
          Expanded(
            child: Navigator(
              key: widget.navigatorKey,
              initialRoute: widget.initialRoute,
              onGenerateRoute: widget.onGenerateRoute,
              observers: [_routeObserver],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolBarRouteObserver extends NavigatorObserver {
  _ToolBarRouteObserver({required this.onRouteChanged});

  final ValueChanged<String?> onRouteChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onRouteChanged(route.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    onRouteChanged(newRoute?.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onRouteChanged(previousRoute?.settings.name);
  }
}
