import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/cubit/portfolio_cubit.dart';
import 'package:portfolio/core/models/portfolio_model.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/core/widgets/glassmorphic_container.dart';

class ExperienceTimelineSection extends StatelessWidget {
  const ExperienceTimelineSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoaded) {
          final experiences = state.portfolioData.experiences;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section header
                  Text(
                    'Experience',
                    style: AppStyles.h4TextStyle.copyWith(
                      color: AppColors.whiteOp9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'My professional journey so far',
                    style: AppStyles.lgTextRegularStyle.copyWith(
                      color: AppColors.whiteOp4,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Timeline entries
                  ...List.generate(experiences.length, (index) {
                    final experience = experiences[index];
                    final isLast = index == experiences.length - 1;
                    return _TimelineEntry(
                      experience: experience,
                      isLast: isLast,
                    );
                  }),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  final Experience experience;
  final bool isLast;

  const _TimelineEntry({
    required this.experience,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column (dot + line)
          SizedBox(
            width: 32,
            child: Column(
              children: [
                const SizedBox(height: 6),
                // Glowing dot
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4f46e5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4f46e5).withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                // Connecting line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: GlassmorphicContainer(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row: logo + company + duration
                    Row(
                      children: [
                        // Company logo
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            experience.logoAsset,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Company name + role
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                experience.companyName,
                                style: AppStyles.lgTextBoldStyle.copyWith(
                                  color: AppColors.whiteOp9,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                experience.role,
                                style: AppStyles.mdTextRegularStyle.copyWith(
                                  color: const Color(0xFF818cf8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Duration + Location
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 13,
                          color: Colors.white.withOpacity(0.4),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          experience.duration,
                          style: AppStyles.smTextRegularStyle.copyWith(
                            color: AppColors.whiteOp4,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.location_on_outlined,
                          size: 13,
                          color: Colors.white.withOpacity(0.4),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          experience.location,
                          style: AppStyles.smTextRegularStyle.copyWith(
                            color: AppColors.whiteOp4,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Summary
                    Text(
                      experience.summary,
                      style: AppStyles.mdTextRegularStyle.copyWith(
                        color: AppColors.whiteOp6,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Highlight chips (first 3 from detailBannerData)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: experience.detailBannerData
                          .take(4)
                          .map((detail) => _HighlightChip(label: detail.title))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightChip extends StatelessWidget {
  final String label;

  const _HighlightChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF4f46e5).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4f46e5).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: AppStyles.xsTextMediumStyle.copyWith(
          color: const Color(0xFFa5b4fc),
        ),
      ),
    );
  }
}
