import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/constants/globals.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/feature/emulator/presentation/cubit/settings_manager_cubit.dart';
import 'package:portfolio/feature/emulator/presentation/widget/clean_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _colorSectionExpanded = true;

  final List<Color> _colors = [
    Colors.transparent,
    AppColors.blueShade100,
    AppColors.indigo,
    AppColors.redShade100,
    AppColors.greenShade100,
    AppColors.tealShade100,
    AppColors.nowFloatsColor,
  ];

  final List<String> _colorLabels = [
    'None',
    'Blue',
    'Indigo',
    'Red',
    'Green',
    'Teal',
    'Yellow',
  ];

  @override
  void initState() {
    Globals.isBackDisabled = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsManagerCubit, SettingsManagerState>(
      builder: (context, state) {
        final cubit = context.read<SettingsManagerCubit>();
        final selectedIndex = cubit.index;
        final isDark = cubit.isDarkTheme;

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: const CleanAppBar(
            title: 'Settings',
            backgroundColor: Colors.white,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              // ─── Appearance Section ───
              _buildSectionHeader('APPEARANCE'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Dark Mode Toggle
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade600,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(
                              Icons.dark_mode_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Dark Mode',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          CupertinoSwitch(
                            value: isDark,
                            activeTrackColor: Colors.indigo.shade600,
                            onChanged: (value) {
                              HapticFeedback.vibrate();
                              cubit.toggleTheme(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ─── Background Color Section ───
              _buildSectionHeader('BACKGROUND COLOR'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Accordion header
                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        HapticFeedback.selectionClick();
                        setState(() {
                          _colorSectionExpanded = !_colorSectionExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.teal.shade600,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Icon(
                                Icons.palette_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Accent Color',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            // Current selection indicator
                            if (selectedIndex > 0)
                              Container(
                                width: 18,
                                height: 18,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: _colors[selectedIndex],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                              ),
                            AnimatedRotation(
                              turns: _colorSectionExpanded ? 0.25 : 0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.grey.shade400,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Accordion body
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          children: [
                            Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: List.generate(
                                _colors.length,
                                (index) => _buildColorCircle(
                                  index,
                                  selectedIndex,
                                  cubit,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      crossFadeState: _colorSectionExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ─── Info Section ───
              _buildSectionHeader('ABOUT'),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      Icons.info_outline_rounded,
                      Colors.blue,
                      'Version',
                      '1.0.0',
                    ),
                    Divider(height: 1, indent: 58, color: Colors.grey.shade200),
                    _buildInfoRow(
                      Icons.code_rounded,
                      Colors.orange,
                      'Built with',
                      'Flutter',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 16, 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.grey.shade500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildColorCircle(
    int index,
    int selectedIndex,
    SettingsManagerCubit cubit,
  ) {
    final isSelected = index == selectedIndex;
    final color = _colors[index];
    final isTransparent = color == Colors.transparent;

    return GestureDetector(
      onTap: () {
        HapticFeedback.vibrate();
        cubit.changeColor(index, color);
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isTransparent ? Colors.white : color,
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isSelected ? Colors.indigo.shade600 : Colors.grey.shade300,
                width: isSelected ? 2.5 : 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: (isTransparent ? Colors.indigo : color)
                            .withValues(alpha: 0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: isTransparent
                ? Icon(
                    Icons.block_rounded,
                    size: 18,
                    color: Colors.grey.shade400,
                  )
                : isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 18,
                        color: Colors.white,
                      )
                    : null,
          ),
          const SizedBox(height: 4),
          Text(
            _colorLabels[index],
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? Colors.indigo.shade600 : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    Color iconColor,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Globals.isBackDisabled = true;
    super.dispose();
  }
}
