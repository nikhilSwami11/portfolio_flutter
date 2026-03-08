import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/navigation/route_arguments.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/navigation/routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // ── Text entrance ──
  late final AnimationController _textController;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<Offset>> _slideAnimations;
  late final Animation<double> _buttonFade;
  late final Animation<double> _buttonScale;

  // ── Shatter ──
  late final AnimationController _shatterController;
  bool _shattered = false;
  Rect? _buttonRect;
  final GlobalKey _buttonKey = GlobalKey();
  final GlobalKey _bodyKey = GlobalKey();
  late List<_ShatterPiece> _pieces;

  // Screen fade
  late final Animation<double> _screenFade;

  final List<_TextItem> _items = const [
    _TextItem('Hello,', 32, FontWeight.w400, Colors.black54),
    _TextItem("I'm Nikhil", 40, FontWeight.w700, Colors.black87),
    _TextItem('Software Developer', 22, FontWeight.w500, Colors.indigo),
    _TextItem(
        'Flutter • Android • iOS • Web', 14, FontWeight.w400, Colors.black45),
  ];

  @override
  void initState() {
    super.initState();

    // ── Text entrance ──
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    _fadeAnimations = List.generate(_items.length, (i) {
      final start = i * 0.15;
      final end = start + 0.3;
      return CurvedAnimation(
        parent: _textController,
        curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOut),
      );
    });

    _slideAnimations = List.generate(_items.length, (i) {
      final start = i * 0.15;
      final end = start + 0.35;
      return Tween<Offset>(
        begin: const Offset(0, 0.4),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _textController,
        curve: Interval(start, end.clamp(0.0, 1.0), curve: Curves.easeOutCubic),
      ));
    });

    _buttonFade = CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.75, 1.0, curve: Curves.easeOut),
    );
    _buttonScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.75, 1.0, curve: Curves.easeOutBack),
      ),
    );

    // ── Shatter ──
    _shatterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _screenFade = CurvedAnimation(
      parent: _shatterController,
      curve: const Interval(0.55, 1.0, curve: Curves.easeIn),
    );

    _pieces = [];

    _shatterController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        RouteHelper.pushReplacement(
          Routes.landing,
          context: context,
          animation: RouteAnimationType.fade,
        );
      }
    });

    _textController.forward();
  }

  @override
  void dispose() {
    _textController.dispose();
    _shatterController.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    if (_shattered) return;
    HapticFeedback.vibrate();

    // Measure button position relative to the body Stack
    final btnBox = _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    final bodyBox = _bodyKey.currentContext?.findRenderObject() as RenderBox?;
    if (btnBox == null || bodyBox == null) return;

    final pos = btnBox.localToGlobal(Offset.zero, ancestor: bodyBox);
    _buttonRect = Rect.fromLTWH(
      pos.dx,
      pos.dy,
      btnBox.size.width,
      btnBox.size.height,
    );

    // Break the button into a grid of pieces
    _pieces = _generatePieces(_buttonRect!);

    setState(() => _shattered = true);
    _shatterController.forward();
  }

  List<_ShatterPiece> _generatePieces(Rect rect) {
    final rng = Random();
    const cols = 8;
    const rows = 3;
    final pieceW = rect.width / cols;
    final pieceH = rect.height / rows;
    final centerX = rect.center.dx;
    final centerY = rect.center.dy;

    final pieces = <_ShatterPiece>[];

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final x = rect.left + c * pieceW;
        final y = rect.top + r * pieceH;

        // Direction away from center
        final dx = (x + pieceW / 2) - centerX;
        final dy = (y + pieceH / 2) - centerY;
        final dist = sqrt(dx * dx + dy * dy).clamp(1.0, double.infinity);

        // Velocity: outward from center + random jitter
        final vx = (dx / dist) * (120 + rng.nextDouble() * 200) +
            (rng.nextDouble() - 0.5) * 80;
        final vy = (dy / dist) * (80 + rng.nextDouble() * 160) +
            rng.nextDouble() * 100; // slight gravity bias downward

        // Random rotation
        final rotSpeed = (rng.nextDouble() - 0.5) * 6;

        // Shade variation for depth
        final shade = (rng.nextDouble() * 0.15);

        pieces.add(_ShatterPiece(
          startX: x,
          startY: y,
          width: pieceW,
          height: pieceH,
          velocityX: vx,
          velocityY: vy,
          rotation: rotSpeed,
          shade: shade,
        ));
      }
    }
    return pieces;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        key: _bodyKey,
        children: [
          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),
                  ...List.generate(_items.length, (i) {
                    return SlideTransition(
                      position: _slideAnimations[i],
                      child: FadeTransition(
                        opacity: _fadeAnimations[i],
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                i == 1 ? 16 : (i == _items.length - 1 ? 0 : 6),
                          ),
                          child: Text(
                            _items[i].text,
                            style: TextStyle(
                              fontSize: _items[i].fontSize,
                              fontWeight: _items[i].fontWeight,
                              color: _items[i].color,
                              letterSpacing: i == 3 ? 1.0 : 0.3,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const Spacer(flex: 2),
                  // Button (hidden after shatter)
                  if (!_shattered)
                    Center(
                      child: FadeTransition(
                        opacity: _buttonFade,
                        child: ScaleTransition(
                          scale: _buttonScale,
                          child: ElevatedButton(
                            key: _buttonKey,
                            onPressed: _onGetStarted,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (_shattered) const SizedBox(height: 48),
                  const Spacer(flex: 1),
                ],
              ),
            ),
          ),

          // Shatter pieces overlay
          if (_shattered)
            AnimatedBuilder(
              animation: _shatterController,
              builder: (context, _) {
                final t = _shatterController.value;
                return Stack(
                  children: _pieces.map((piece) {
                    final x = piece.startX + piece.velocityX * t;
                    final y = piece.startY +
                        piece.velocityY * t +
                        300 * t * t; // gravity
                    final rotation = piece.rotation * t;
                    final opacity = (1.0 - t * 1.5).clamp(0.0, 1.0);
                    final scale = 1.0 - t * 0.3;

                    return Positioned(
                      left: x,
                      top: y,
                      child: Transform.rotate(
                        angle: rotation,
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: Container(
                              width: piece.width,
                              height: piece.height,
                              decoration: BoxDecoration(
                                color: Colors.black87
                                    .withValues(alpha: 1.0 - piece.shade),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),

          // Screen fade to white
          if (_shattered)
            AnimatedBuilder(
              animation: _screenFade,
              builder: (context, _) {
                return IgnorePointer(
                  child: Container(
                    color: Colors.white.withValues(alpha: _screenFade.value),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

// ─── Models ───

class _TextItem {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const _TextItem(this.text, this.fontSize, this.fontWeight, this.color);
}

class _ShatterPiece {
  final double startX, startY;
  final double width, height;
  final double velocityX, velocityY;
  final double rotation;
  final double shade;

  const _ShatterPiece({
    required this.startX,
    required this.startY,
    required this.width,
    required this.height,
    required this.velocityX,
    required this.velocityY,
    required this.rotation,
    required this.shade,
  });
}
