import 'package:auto_mates_admin/controller/admin_home_screen_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final AdminHomeScreenController controller = Get.put(AdminHomeScreenController());
    final List<Widget> pages = [
      Center(child: Text('Page 1')),
      Center(child: Text('Page 2')),
      Center(child: Text('Page 3')),
      Center(child: Text('Page 4')),
    ];
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            
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
  // Widget sidebarItem(int index, String label, AdminHomeScreenController controller) {
  //   return GestureDetector(
  //     onTap: () => controller.changePage(index),
  //     child: Obx(() => Container(
  //       padding: const EdgeInsets.all(16.0),
  //       color: controller.selectedIndex.value == index ? Colors.blue : Colors.transparent,
  //       child: Text(
  //         label,
  //         style: TextStyle(
  //           color: controller.selectedIndex.value == index ? Colors.white : Colors.grey,
  //           fontSize: 18,
  //         ),
  //       ),
  //     )),
  //   );
  // }
}