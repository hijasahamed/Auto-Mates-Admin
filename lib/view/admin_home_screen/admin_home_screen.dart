import 'package:auto_mates_admin/controller/admin_home_screen_controller.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen_side_bar/admin_home_screen_side_bar.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/overview_screen/overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AdminHomeScreenController controller = Get.put(AdminHomeScreenController());
    final List<Widget> pages = [
      OverviewScreen(screenSize: screenSize,), 
      Center(child: Text('Page 2')),
      Center(child: Text('Page 3')),
      Center(child: Text('Page 4')),
    ];
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            AdminHomeScreenSideBar(screenSize: screenSize, controller: controller),
            Expanded(
              flex: 5,
              child: Container(
                color: colorBlack,
                child: Obx(() => pages[controller.selectedIndex.value]),
              )
            )
          ],
        )
      ),
    );
  }
}