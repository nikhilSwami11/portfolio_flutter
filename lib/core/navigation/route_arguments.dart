enum RouteAnimationType {
  slideLeft,
  slideRight,
  slideTop,
  slideBottom,
  zoomOut,
  zoomOutAndFade,
  fade,
}

class RouteArguments {
  final Object? arguments;
  final RouteAnimationType? animation;
  const RouteArguments(this.arguments, {this.animation});
}
