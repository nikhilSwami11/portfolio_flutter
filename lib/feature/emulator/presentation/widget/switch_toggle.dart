import 'package:flutter/material.dart';
import 'package:portfolio/core/theme/colors.dart';

class SwitchToggle extends StatefulWidget {
  final Function onTap;
  final bool isAmPm;
  const SwitchToggle({super.key, required this.onTap, required this.isAmPm});

  @override
  State<SwitchToggle> createState() => _SwitchToggleState();
}

class _SwitchToggleState extends State<SwitchToggle> {
  bool isAmPm = false;

  @override
  void initState() {
    isAmPm = widget.isAmPm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: isAmPm,
      activeColor: AppColors.black,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        widget.onTap.call(value);
        setState(() {
          isAmPm = value;
        });
      },
    );
  }
}
