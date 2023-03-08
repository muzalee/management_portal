import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (val) {},
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/images/profile.jpg",
        ),
      ),
      iconSize: 40,
      offset: const Offset(0.0, kToolbarHeight),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (context) =>
      [
        PopupMenuItem(
          value: 0,
          enabled: false,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/profile.jpg",
                  height: 40,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('John Doe', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600)),
                  Text('Admin', style: TextStyle(color: Colors.black45)),
                ],
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: const [
              Icon(Icons.logout, color: Colors.black54),
              SizedBox(width: 5),
              Text('Logout', style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ],
    );
  }
}