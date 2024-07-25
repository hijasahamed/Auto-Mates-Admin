import 'package:auto_mates_admin/view/admin_home_screen/side_panel/side_panel.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          SidePanel(screenSize: screenSize),
        ],
      ),
    );
  }
}