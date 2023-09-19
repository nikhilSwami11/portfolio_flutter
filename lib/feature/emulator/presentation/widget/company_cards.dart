import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/padding.dart';
import 'package:portfolio/core/constants/spacers.dart';
import 'package:portfolio/core/constants/app_assets.dart';
import 'package:portfolio/core/theme/text_styles.dart';

class CompanyCards extends StatelessWidget {
  final String companySite;
  final String imageIcon;
  final String title;
  final String duration;
  final String location;
  final String companyName;
  final String jobDescription;
  final Color backgroundColor;
  final String appName;
  final String appDownloads;
  const CompanyCards({
    super.key,
    required this.companySite,
    required this.imageIcon,
    required this.title,
    required this.duration,
    required this.location,
    required this.companyName,
    required this.jobDescription,
    required this.backgroundColor,
    required this.appName,
    required this.appDownloads,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(width: 2, color: Colors.black),
      ),
      child: Column(children: [
        ColoredBox(
          color: Colors.black,
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
                  duration,
                  style:
                      AppStyles.mdTextBoldStyle.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            children: [
              spacerW10,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      companyName,
                      style: AppStyles.h6TextStyle,
                    ),
                    Text(
                      title,
                      style: AppStyles.mdTextBoldStyle,
                    ),
                    Text(
                      jobDescription,
                      style: AppStyles.smTextMediumStyle
                          .copyWith(color: Colors.grey.shade800),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Padding(
                padding: paddingH10V4,
                child: Image.asset(
                  imageIcon,
                  height: 80,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingH5V4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppAssets.appStoreIcons,
                width: 40,
              ),
              Text(
                ' $appName$appDownloads',
                style: AppStyles.smTextBoldStyle,
              ),
              const Spacer(),
              const Text(
                "view more >>",
                style: AppStyles.smTextBoldStyle,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
