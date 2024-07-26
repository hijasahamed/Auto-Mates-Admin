import 'package:auto_mates_admin/view/admin_login_screen/admin_login_box/admin_login_box.dart';
import 'package:auto_mates_admin/view/admin_login_screen/admin_login_image/admin_login_image.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: Padding(
          padding: EdgeInsets.all(screenSize.width/100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AdminLoginImage(screenSize: screenSize),
              AdminLoginBox(screenSize: screenSize),
            ],
          ),
        ),
      ),
    );
  }
}