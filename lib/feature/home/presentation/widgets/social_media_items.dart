import 'package:flutter/material.dart';

class SocialMediaIcons extends StatefulWidget {
  final Color hoverColor;
  final String path;
  final Color color;
  final Function onTap;
  const SocialMediaIcons(
      {super.key,
      required this.hoverColor,
      required this.color,
      required this.onTap,
      required this.path});

  @override
  State<SocialMediaIcons> createState() => _SocialMediaIconsState();
}

class _SocialMediaIconsState extends State<SocialMediaIcons> {
  late Color _currentColor;

  @override
  void initState() {
    _currentColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onTap.call();
        },
        child: MouseRegion(
          onEnter: _changeToHoverColor,
          onExit: _changeToNormalColor,
          child: Image.asset(
            widget.path,
            height: 20,
            width: 20,
            color: _currentColor,
          ),
        ));
  }

  void _changeToHoverColor(PointerEvent details) {
    setState(() {
      _currentColor = widget.hoverColor;
    });
  }

  void _changeToNormalColor(PointerEvent details) {
    setState(() {
      _currentColor = widget.color;
    });
  }
}
