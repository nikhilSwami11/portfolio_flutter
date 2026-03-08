import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/string_constants.dart';
import 'package:portfolio/core/cubit/portfolio_cubit.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/widget/emulator_widget.dart';
import 'package:portfolio/feature/home/presentation/widgets/experience_timeline_section.dart';
import 'package:portfolio/feature/home/presentation/widgets/skills_grid_section.dart';
import 'package:portfolio/feature/home/presentation/widgets/social_links.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _gradientController;

  // Staggered entrance animations
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleFade;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _descFade;
  late final Animation<Offset> _descSlide;
  late final Animation<double> _credentialsFade;
  late final Animation<double> _emulatorFade;
  late final Animation<Offset> _emulatorSlide;
  late final Animation<double> _experienceFade;
  late final Animation<Offset> _experienceSlide;
  late final Animation<double> _skillsFade;
  late final Animation<Offset> _skillsSlide;
  late final Animation<double> _footerFade;

  @override
  void initState() {
    super.initState();

    // ── Entrance animation ──
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _titleFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    ));

    _subtitleFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.1, 0.4, curve: Curves.easeOut),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.1, 0.45, curve: Curves.easeOutCubic),
    ));

    _descFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.2, 0.5, curve: Curves.easeOut),
    );
    _descSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.2, 0.55, curve: Curves.easeOutCubic),
    ));

    _credentialsFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.32, 0.55, curve: Curves.easeOut),
    );

    _emulatorFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.4, 0.75, curve: Curves.easeOut),
    );
    _emulatorSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
    ));

    _experienceFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.6, 0.85, curve: Curves.easeOut),
    );
    _experienceSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.6, 0.85, curve: Curves.easeOutCubic),
    ));

    _skillsFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.7, 0.9, curve: Curves.easeOut),
    );
    _skillsSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.7, 0.9, curve: Curves.easeOutCubic),
    ));

    _footerFade = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.85, 1.0, curve: Curves.easeOut),
    );

    // ── Slow gradient animation ──
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: AnimatedBuilder(
        animation: _gradientController,
        builder: (context, child) {
          final t = _gradientController.value;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFF0a0a1a),
                    const Color(0xFF0d1b2a),
                    t,
                  )!,
                  Color.lerp(
                    const Color(0xFF0f0f23),
                    const Color(0xFF1a0a2e),
                    t,
                  )!,
                  Color.lerp(
                    const Color(0xFF0a0a1a),
                    const Color(0xFF0a1628),
                    t,
                  )!,
                ],
              ),
            ),
            child: child,
          );
        },
        child: BlocBuilder<PortfolioCubit, PortfolioState>(
          builder: (context, state) {
            if (state is PortfolioLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PortfolioError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is PortfolioLoaded) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),

                    // Hero text block — Apple-style cascade
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Line 1: "Hello."
                            SlideTransition(
                              position: _titleSlide,
                              child: FadeTransition(
                                opacity: _titleFade,
                                child: Text(
                                  StringConstants.heroLine1,
                                  style: AppStyles.h1TextStyle.copyWith(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w800,
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: [
                                          Color(0xFF818cf8),
                                          Color(0xFF38bdf8),
                                        ],
                                      ).createShader(
                                          const Rect.fromLTWH(0, 0, 200, 70)),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Line 2: "I'm Nikhil."
                            SlideTransition(
                              position: _subtitleSlide,
                              child: FadeTransition(
                                opacity: _subtitleFade,
                                child: Text(
                                  StringConstants.heroLine2,
                                  style: AppStyles.h1TextStyle.copyWith(
                                    fontSize: 64,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.whiteOp9,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Line 3: "I build intelligent\nsoftware."
                            SlideTransition(
                              position: _descSlide,
                              child: FadeTransition(
                                opacity: _descFade,
                                child: Text(
                                  StringConstants.heroLine3,
                                  style: AppStyles.h3TextStyle.copyWith(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whiteOp4,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Credentials — role titles
                            FadeTransition(
                              opacity: _credentialsFade,
                              child: Text(
                                StringConstants.heroCredentials,
                                style: AppStyles.lgTextMediumStyle.copyWith(
                                  color: const Color(0xFF38bdf8),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 72),

                    // Emulator with glow
                    SlideTransition(
                      position: _emulatorSlide,
                      child: FadeTransition(
                        opacity: _emulatorFade,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Glow behind emulator
                            Container(
                              width: 280,
                              height: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF4f46e5)
                                        .withValues(alpha: 0.15),
                                    blurRadius: 120,
                                    spreadRadius: 40,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF0ea5e9)
                                        .withValues(alpha: 0.08),
                                    blurRadius: 80,
                                    spreadRadius: 20,
                                    offset: const Offset(30, -20),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: paddingH16V16,
                              child: Emulator(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),

                    // Experience timeline
                    SlideTransition(
                      position: _experienceSlide,
                      child: FadeTransition(
                        opacity: _experienceFade,
                        child: const ExperienceTimelineSection(),
                      ),
                    ),

                    const SizedBox(height: 100),

                    // Skills grid
                    SlideTransition(
                      position: _skillsSlide,
                      child: FadeTransition(
                        opacity: _skillsFade,
                        child: const SkillsGridSection(),
                      ),
                    ),

                    const SizedBox(height: 100),

                    // Footer
                    FadeTransition(
                      opacity: _footerFade,
                      child: Column(
                        children: [
                          Text(
                            StringConstants.footerTitle,
                            style: AppStyles.h6TextStyle.copyWith(
                              color: AppColors.whiteOp6,
                            ),
                          ),
                          Text(
                            StringConstants.footerEmail,
                            style: AppStyles.lgTextMediumStyle.copyWith(
                              color: AppColors.whiteOp9,
                            ),
                          ),
                          const SizedBox(height: 40),
                          const SocialLinksWidget(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
