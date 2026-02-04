import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/cubit/portfolio_cubit.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/feature/home/presentation/widgets/social_media_items.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksWidget extends StatelessWidget {
  const SocialLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is PortfolioLoaded) {
          final links = state.portfolioData.socialLinks;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: links.map((link) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SocialMediaIcons(
                  hoverColor: link.hoverColorHex != null
                      ? Color(int.parse(
                          link.hoverColorHex!.replaceFirst('#', '0xFF')))
                      : AppColors.whiteOp6,
                  color: AppColors.whiteOp6,
                  onTap: () async {
                    final Uri url = Uri.parse(link.url);
                    await launchUrl(url);
                  },
                  path: link.iconAsset,
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
