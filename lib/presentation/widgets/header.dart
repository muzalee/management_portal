import 'package:flutter/material.dart';
import 'package:management_portal/presentation/widgets/responsive.dart';

import 'profile_card.dart';

class Header extends StatelessWidget {
  final VoidCallback callback;
  const Header({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black54),
            onPressed: callback,
          ),
        Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const ProfileCard()
      ],
    );
  }
}