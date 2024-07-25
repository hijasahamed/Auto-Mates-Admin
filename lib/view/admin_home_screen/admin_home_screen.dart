import 'package:auto_mates_admin/view/admin_home_screen/side_panel/side_panel.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;   
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