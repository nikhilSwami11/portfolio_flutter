import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/settings_manager_cubit.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: const BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(width: 1, color: Colors.black))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "N .S .O .S.",
            style: AppStyles.smTextBoldStyle.copyWith(color: Colors.black),
          ),
          BlocBuilder<SettingsManagerCubit, SettingsManagerState>(
            builder: (context, state) {
              return StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 30)),
                builder: (context, snapshot) {
                  final String timeString =
                      context.read<SettingsManagerCubit>().isAmPm
                          ? DateFormat('hh:mm a').format(DateTime.now())
                          : DateFormat('HH:mm').format(DateTime.now());
                  return Text(
                    timeString,
                    style:
                        AppStyles.smTextBoldStyle.copyWith(color: Colors.black),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
