import 'package:flutter/material.dart';

class NotificationsDrawer extends StatelessWidget {
  const NotificationsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Center(
          child: Text(
            "Notifications",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
