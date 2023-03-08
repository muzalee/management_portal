import 'package:flutter/material.dart';
import 'package:management_portal/core/color_const.dart';

import '../widgets/header.dart';
import '../widgets/responsive.dart';
import '../widgets/side_menu.dart';

class MainNav extends StatelessWidget {
  final Widget child;
  MainNav({super.key, required this.child});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConst.tertiary,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Header(callback: controlMenu),
                    const SizedBox(height: 10),
                    Expanded(
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //local functions
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
