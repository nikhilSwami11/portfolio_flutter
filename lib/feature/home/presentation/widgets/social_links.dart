import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/constants/string_constants.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/feature/home/presentation/widgets/social_media_items.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksWidget extends StatelessWidget {
  const SocialLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaIcons(
          hoverColor: AppColors.linkedIn,
          color: AppColors.whiteOp6,
          onTap: () async {
            final Uri _url = Uri.parse(StringConstants.linkedinUrl);
            await launchUrl(_url);
          },
          path: AppAssets.linkedinLogo,
        ),
        spacerW10,
        SocialMediaIcons(
          hoverColor: AppColors.instagram,
          color: AppColors.whiteOp6,
          onTap: () async {
            final Uri _url = Uri.parse(StringConstants.instagramUrl);
            await launchUrl(_url);
          },
          path: AppAssets.instagramLogo,
        ),
      ],
    );
  }
}
