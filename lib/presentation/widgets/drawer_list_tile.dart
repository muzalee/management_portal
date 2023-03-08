import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback press;
  const DrawerListTile({super.key, required this.title, required this.iconData, required this.press,});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(iconData, size: 20, color: Colors.black54),
      title: Text(title, style: const TextStyle(color: Colors.black54)),
    );
  }
}