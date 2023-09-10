import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/text_styles.dart';

class LocalApps extends StatelessWidget {
  final Function onTap;
  final String name;

  final String iconUrl;
  const LocalApps(
      {super.key,
      required this.onTap,
      required this.name,
      required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconUrl,
            width: 50,
            height: 50,
          ),
          Text(
            name,
            style: AppStyles.smTextBoldStyle,
          ),
        ],
      ),
    );
  }
}
