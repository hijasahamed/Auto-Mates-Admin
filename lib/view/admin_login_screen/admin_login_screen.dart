import 'package:auto_mates_admin/view/admin_login_screen/admin_login_box/admin_login_box.dart';
import 'package:auto_mates_admin/view/admin_login_screen/admin_login_image/admin_login_image.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/model/responsive.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    if (Responsive.isDesktop(context) || Responsive.isTablet(context)) {
      return Scaffold(
        backgroundColor: loginBackgroundColor,
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: EdgeInsets.all(screenSize.width / 100),
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
    } else {
      return Scaffold(
        backgroundColor: loginBackgroundColor,
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: EdgeInsets.all(screenSize.width / 100),
            child: Column(
              children: [
                Container(
                  height: screenSize.height / 2.3,
                  width: screenSize.width / 1.3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/login background.png'),
                          fit: BoxFit.cover)),
                ),
                AdminLoginBox(screenSize: screenSize),
              ],
            ),
          ),
        ),
      );
    }
  }
}
