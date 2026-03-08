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
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: iconUrl != null
                ? Image.asset(
                    iconUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: iconColor ?? Colors.blue,
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: AppStyles.xsTextMediumStyle.copyWith(
            color: textColor ?? Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
