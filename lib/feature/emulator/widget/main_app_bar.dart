import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/styles/text_styles.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color color;
  final String title;
  final Function? onTap;
  const MainAppBar(
      {super.key, required this.color, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      backgroundColor: Colors.black,
      leading: NeoPopButton(
        color: color,
        onTapUp: () {
          HapticFeedback.vibrate();
          if (onTap != null) {
            onTap?.call();
            return;
          }
          RouteHelper.pop(context: context);
        },
        onTapDown: () => HapticFeedback.vibrate(),
        parentColor: Colors.transparent,
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black,
        ),
      ),
      title: Text(
        title,
        style: AppStyles.h6TextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
