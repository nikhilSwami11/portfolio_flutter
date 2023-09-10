import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopop/neopop.dart';
import 'package:portfolio/core/styles/text_styles.dart';
import 'package:portfolio/feature/emulator/cubit/nav_index_cubit.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({
    super.key,
  });

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final List<String> _tabs = const ["Home", "Work", "Education"];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.indigo.shade900,
      child: NeoPopShimmer(
        shimmerColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: BlocBuilder<NavIndexCubit, NavIndexState>(
            builder: (context, state) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    _tabs.length,
                    (index) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: NeoPopTiltedButton(
                          key: UniqueKey(),
                          color: context.read<NavIndexCubit>().index == index
                              ? Colors.yellow.shade600
                              : Colors.white,
                          onTapUp: () {
                            context.read<NavIndexCubit>().updateNavIndex(index);
                          },
                          isFloating:
                              context.read<NavIndexCubit>().index == index,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              child: Text(
                                _tabs[index],
                                textAlign: TextAlign.center,
                                style: AppStyles.mdTextMediumStyle,
                              )),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
