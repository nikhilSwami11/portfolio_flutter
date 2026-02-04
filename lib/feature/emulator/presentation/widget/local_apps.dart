import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/text_styles.dart';

class LocalApps extends StatelessWidget {
  final Function? onTap;
  final String name;

  final String? iconUrl;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final Color? shadowColor;

  const LocalApps({
    super.key,
    this.onTap,
    required this.name,
    this.iconUrl,
    this.icon,
    this.iconColor,
    this.textColor,
    this.shadowColor,
  }) : assert(iconUrl != null || icon != null,
            'Either iconUrl or icon must be provided');

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color:
                icon != null ? (iconColor ?? Colors.blue) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                )
              : Image.asset(
                  iconUrl!,
                  width: 50,
                  height: 50,
                ),
        ),
        const SizedBox(height: 5),
        Text(
          name,
          style: AppStyles.smTextBoldStyle.copyWith(
            color: textColor ?? Colors.white,
            shadows: [
              Shadow(
                offset: const Offset(0, 1),
                blurRadius: 2.0,
                color: shadowColor ?? Colors.black,
              ),
            ],
          ),
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: () {
          onTap!.call();
        },
        child: content,
      );
    }
    return content;
  }
}
