import 'package:auto_mates_admin/controller/admin_home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AdminHomeScreenSideBarItem extends StatelessWidget {
  const AdminHomeScreenSideBarItem({super.key,required this.index,required this.label,required this.controller});
  final int index;
  final String label;
  final AdminHomeScreenController controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: Obx(() => Container(
        padding: const EdgeInsets.all(16.0),
        color: controller.selectedIndex.value == index ? Colors.blue : Colors.transparent,
        child: Text(
          label,
          style: TextStyle(
            color: controller.selectedIndex.value == index ? Colors.white : Colors.grey,
            fontSize: 18,
          ),
        ),
      )),
    );
  }
}