import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/core/theme/text_styles.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: Stream.periodic(const Duration(seconds: 30)),
            builder: (context, snapshot) {
              final String timeString =
                  DateFormat('HH:mm').format(DateTime.now());
              return Text(
                timeString,
                style: AppStyles.xsTextMediumStyle
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w600),
              );
            },
          ),
          const Icon(
            Icons.battery_full_rounded,
            color: Colors.black,
            size: 20,
          ),
        ],
      ),
    );
  }
}
