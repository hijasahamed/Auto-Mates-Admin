import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen_side_bar/admin_home_screen_side_bar.dart';
import 'package:auto_mates_admin/view/revenue_earned_screen/revenue_earned_screen.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/overview_screen/overview_screen.dart';
import 'package:auto_mates_admin/view/sellers_screen/sellers_screen.dart';
import 'package:auto_mates_admin/view/users_screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AdminHomeScreenController adminHomeScreenController = Get.put(AdminHomeScreenController());
    final List<Widget> pages = [
      OverviewScreen(screenSize: screenSize,adminHomeScreenController: adminHomeScreenController,), 
      SellersScreen(screenSize: screenSize,),
      UsersScreen(screenSize: screenSize,),
      RevenueEarnedScreen(screenSize: screenSize,)
    ];
    return Scaffold(
      backgroundColor: colorBlack,
      body: SafeArea(
        child: Row(
          children: [
            AdminHomeScreenSideBar(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController),
            Expanded(
              flex: 5,
              child: Container(
                color: colorBlack,
                child: Obx(() => pages[adminHomeScreenController.selectedIndex.value]),
              )
            )
          ],
        )
      ),
    );
  }
}