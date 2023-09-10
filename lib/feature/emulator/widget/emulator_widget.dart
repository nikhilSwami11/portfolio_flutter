import 'package:flutter/material.dart';
import 'package:portfolio/core/components/internal_routing.dart';
import 'package:portfolio/core/constants/globals.dart';
import 'package:portfolio/core/navigation/generator/mobile_route_generator.dart';
import 'package:portfolio/core/navigation/route_helper.dart';
import 'package:portfolio/core/navigation/routes.dart';

class Emulator extends StatelessWidget {
  const Emulator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 610,
        width: 340,
        margin: const EdgeInsets.only(left: 1, bottom: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0, 1))
            ]),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: InternalRoutingWidget(
                  navigatorKey: RouteHelper.mobileNavigatorKey,
                  onGenerateRoute: MobileRouteGenerator.generateRoute,
                  initialRoute: Routes.onboarding,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    child: IconButton(
                  icon: const Icon(Icons.fiber_new_outlined),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: () {},
                )),
                Flexible(
                  child: InkWell(
                    onTap: () {
                      if (!Globals.isBackDisabled) {
                        RouteHelper.popUntil(Routes.landing,
                            context: RouteHelper.mobileNavigatorContext);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          shape: BoxShape.circle),
                    ),
                  ),
                ),
                Flexible(
                    child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.white,
                  onPressed: () {
                    if (!Globals.isBackDisabled) {
                      RouteHelper.pop(
                          context: RouteHelper.mobileNavigatorContext);
                    }
                  },
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
