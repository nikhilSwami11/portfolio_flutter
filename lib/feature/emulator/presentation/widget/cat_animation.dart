import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/widget/back_hole_clipper.dart';

class CatAnimation extends StatefulWidget {
  final bool isOnboarding;
  const CatAnimation({super.key, this.isOnboarding = true});

  @override
  State<CatAnimation> createState() => _CatAnimationState();
}

class _CatAnimationState extends State<CatAnimation>
    with TickerProviderStateMixin {
  final catSize = 150.0;
  bool displayButton = false;

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
    return Column(
      children: [
        SizedBox(
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
                              setState(() {
                                displayButton = true;
                              });
                              HapticFeedback.vibrate();
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
                if (displayButton)
                  Positioned(
                    top: 40,
                    child: NeoPopButton(
                      color: Colors.yellowAccent.shade700,
                      onTapUp: () async {
                        displayButton = false;
                        holeAnimationController.forward();
                        await catOffsetAnimationController.reverse();

                        await Future.delayed(const Duration(milliseconds: 200),
                            () => holeAnimationController.reverse());

                        HapticFeedback.vibrate();
                      },
                      onTapDown: () => HapticFeedback.vibrate(),
                      parentColor: Colors.transparent,
                      child: const Padding(
                        padding: paddingH10V4,
                        child: Text(
                          'Bring Back!!',
                          style: AppStyles.lgTextBoldStyle,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
