import 'package:auto_mates_admin/controller/admin_home_screen_controller.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen_side_bar/admin_home_screen_side_bar_item/admin_home_screen_side_bar_item.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminHomeScreenSideBar extends StatelessWidget {
  const AdminHomeScreenSideBar({super.key,required this.screenSize,required this.controller});
  final Size screenSize;
  final AdminHomeScreenController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: sideBarColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [  
            Padding(
              padding:  EdgeInsets.only(bottom: screenSize.width/100,top: screenSize.width/100),
              child: TextWidget(text: 'AutoMates', color: colorWhite, size: screenSize.width/45, weight: FontWeight.w500),
            ),
            AdminHomeScreenSideBarItem(index: 0, label: 'Overview', controller: controller),
            AdminHomeScreenSideBarItem(index: 1, label: 'Sellers', controller: controller),
            AdminHomeScreenSideBarItem(index: 2, label: 'Users', controller: controller),
          ],
        ),
      )
    );
  }
}