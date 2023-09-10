import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/navigation/route_arguments.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/navigation/routes.dart';
import 'package:portfolio/feature/emulator/widget/back_hole_clipper.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CatAnimationWidget()),
    );
  }
}

class CatAnimationWidget extends StatefulWidget {
  final bool isOnboarding;
  const CatAnimationWidget({Key? key, this.isOnboarding = true})
      : super(key: key);

  @override
  State<CatAnimationWidget> createState() => _CatAnimationWidgetState();
}

class _CatAnimationWidgetState extends State<CatAnimationWidget>
    with TickerProviderStateMixin {
  final catSize = 150.0;

  late final holeSizeTween = Tween<double>(
    begin: 0,
    end: 1.5 * catSize,
  );
  late final holeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  double get holeSize => holeSizeTween.evaluate(holeAnimationController);
  late final catOffsetAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final catOffsetTween = Tween<double>(
    begin: 0,
    end: 2 * catSize,
  ).chain(CurveTween(curve: Curves.easeInBack));
  late final catRotationTween = Tween<double>(
    begin: 0,
    end: 0.5,
  ).chain(CurveTween(curve: Curves.easeInBack));
  late final catElevationTween = Tween<double>(
    begin: 2,
    end: 20,
  );

  double get catOffset => catOffsetTween.evaluate(catOffsetAnimationController);
  double get catRotation =>
      catRotationTween.evaluate(catOffsetAnimationController);
  double get catElevation =>
      catElevationTween.evaluate(catOffsetAnimationController);

  @override
  void initState() {
    holeAnimationController.addListener(() => setState(() {}));
    catOffsetAnimationController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    holeAnimationController.dispose();
    catOffsetAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: catSize * 1.25,
      width: double.infinity,
      child: ClipPath(
        clipper: BlackHoleClipper(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: holeSize,
              child: Image.asset(
                AppAssets.blackHole,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              child: Center(
                child: Transform.translate(
                  offset: Offset(0, catOffset),
                  child: Transform.rotate(
                    angle: catRotation,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: (() async {
                          holeAnimationController.forward();
                          await catOffsetAnimationController.forward();
                          await Future.delayed(
                              const Duration(milliseconds: 200),
                              () => holeAnimationController.reverse());
                          HapticFeedback.vibrate();
                          RouteHelper.pushReplacement(Routes.landing,
                              context: context,
                              animation: RouteAnimationType.zoomOutAndFade);
                        }),
                        child: Image.asset(
                          AppAssets.cat,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
