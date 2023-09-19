import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';

class EducationCard extends StatefulWidget {
  final String marks;
  final String instituteName;
  final String finalYear;
  final String location;
  final String degree;
  final String imagePath;
  const EducationCard({
    super.key,
    required this.marks,
    required this.instituteName,
    required this.finalYear,
    required this.location,
    required this.degree,
    required this.imagePath,
  });

  @override
  _EducationCardState createState() => _EducationCardState();
}

class _EducationCardState extends State<EducationCard> {
  late bool _showFrontSide;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildFlipAnimation(),
    );
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) =>
            Stack(children: [widget ?? const SizedBox.shrink(), ...list]),
        child: _showFrontSide ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: const ValueKey(true),
      backgroundColor: Colors.white,
      faceName: "Front",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColoredBox(
            color: Colors.blue.shade900,
            child: Padding(
              padding: paddingH10V4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppAssets.threeDots,
                    width: 30,
                  ),
                  Text(
                    "Tap to Reveal",
                    style:
                        AppStyles.mdTextBoldStyle.copyWith(color: Colors.white),
                  ),
                  Text(
                    widget.finalYear,
                    style:
                        AppStyles.mdTextBoldStyle.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          spacerH10,
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: paddingH10V4,
                    child: Text(
                      widget.instituteName,
                      style:
                          AppStyles.h7TextStyle.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                Image.asset(
                  widget.imagePath,
                  width: 70,
                ),
                spacerW5
              ],
            ),
          ),
          Padding(
            padding: paddingH10V4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.degree,
                  style: AppStyles.h7TextStyle.copyWith(color: Colors.black),
                ),
                Text(
                  widget.location,
                  style: AppStyles.h7TextStyle.copyWith(color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: const ValueKey(false),
      backgroundColor: AppColors.indigo,
      faceName: "Rear",
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Text(widget.marks,
                style: AppStyles.h4TextStyle.copyWith(color: Colors.black))),
      ),
    );
  }

  Widget __buildLayout(
      {required Key key,
      required Widget child,
      required String faceName,
      required Color backgroundColor}) {
    return Container(
      key: key,
      height: 150,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 2, color: Colors.black)),
      child: Center(child: child),
    );
  }
}
