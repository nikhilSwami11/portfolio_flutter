import 'package:flutter/material.dart';
import 'package:portfolio/core/navigation/route_helper.dart';

class CleanAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final Function? onBack;

  const CleanAppBar({
    super.key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.foregroundColor = Colors.black87,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 44,
      backgroundColor: backgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: foregroundColor,
        ),
        onPressed: () {
          if (onBack != null) {
            onBack!();
          } else {
            RouteHelper.pop(context: context);
          }
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: foregroundColor,
          letterSpacing: 0.3,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
