import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/text_styles.dart';

class CustomSnackBar {
  static show({
    required BuildContext context,
    required String iconPath,
    required bool showIcon,
    required String message,
    required bool isAlertMessage,
    required Color messageColor,
    required Color backgroundColor,
    required String actionText,
    required Color actionColor,
    required bool showAction,
    SnackBarBehavior? snackBehavior = SnackBarBehavior.floating,
    required Function() onActionButtonPressed,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      padding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      content: Padding(
        padding: EdgeInsets.all(isAlertMessage ? 6 : 15),
        child: Row(
          children: [
            Expanded(
              child: Text(message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: isAlertMessage
                      ? AppStyles.smTextMediumStyle
                          .copyWith(color: messageColor)
                      : AppStyles.mdTextMediumStyle
                          .copyWith(color: messageColor)),
            ),
            if (showAction)
              TextButton(
                onPressed: onActionButtonPressed,
                child: Text(
                  actionText,
                  style: AppStyles.mdTextBoldStyle.copyWith(color: actionColor),
                ),
              )
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      margin: isAlertMessage
          ? null
          : const EdgeInsets.fromLTRB(
              16,
              10,
              16,
              0,
            ),
      behavior: snackBehavior,
      shape: isAlertMessage
          ? const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
    ));
  }
}
