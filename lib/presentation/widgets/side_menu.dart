import 'package:flutter/material.dart';
import 'package:management_portal/core/color_const.dart';

import 'drawer_list_tile.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super. key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorConst.secondary,
      elevation: 1,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          DrawerListTile(
            title: "Dashboard",
            iconData: Icons.dashboard_rounded,
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            iconData: Icons.person,
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            iconData: Icons.settings,
            press: () {},
          ),
        ],
      ),
    );
  }
}