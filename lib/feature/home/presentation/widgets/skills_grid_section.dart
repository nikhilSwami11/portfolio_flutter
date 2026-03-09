import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/cubit/portfolio_cubit.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/core/widgets/glassmorphic_container.dart';

class SkillsGridSection extends StatelessWidget {
  const SkillsGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoaded) {
          final about = state.portfolioData.about;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section header
                  Text(
                    'Skills',
                    style: AppStyles.h4TextStyle.copyWith(
                      color: AppColors.whiteOp9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Technologies & tools I work with',
                    style: AppStyles.lgTextRegularStyle.copyWith(
                      color: AppColors.whiteOp4,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Map over skillGroups to display distinct sections
                  ...about.skillGroups.asMap().entries.map((entry) {
                    final index = entry.key;
                    final group = entry.value;
                    
                    final colors = [
                      const Color(0xFF4f46e5), // Indigo
                      const Color(0xFF0ea5e9), // Sky Blue
                      const Color(0xFF10b981), // Emerald
                      const Color(0xFFf59e0b), // Amber
                      const Color(0xFFef4444), // Red
                      const Color(0xFF8b5cf6), // Violet
                    ];
                    final color = colors[index % colors.length];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GlassmorphicContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 4,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  group.category,
                                  style: AppStyles.lgTextBoldStyle.copyWith(
                                    color: AppColors.whiteOp9,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 10,
                              children: group.skills
                                  .map((skill) => _SkillChip(
                                        label: skill,
                                        color: color,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
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

class _SkillChip extends StatefulWidget {
  final String label;
  final Color color;

  const _SkillChip({
    required this.label,
    required this.color,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.color.withOpacity(0.2)
              : widget.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? widget.color.withOpacity(0.5)
                : widget.color.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.color.withOpacity(0.2),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: AppStyles.smTextMediumStyle.copyWith(
            color: _isHovered
                ? Colors.white.withOpacity(0.95)
                : Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
