import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class AdminHomeScreenSideBarItem extends StatelessWidget {
  const AdminHomeScreenSideBarItem({super.key,required this.index,required this.label,required this.controller});
  final int index;
  final String label;
  final AdminHomeScreenController controller;
  @override
  Widget build(BuildContext context) {    
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding:  EdgeInsets.only(bottom: screenSize.width/100,top: screenSize.width/100),
      child: Material(
        color: Colors.transparent,
        child: InkWell(         
          onTap: () => controller.changePage(index),
          child: Obx(() => Ink(
            width: screenSize.width/8,
            height: screenSize.height/15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenSize.width/200),
              color: controller.selectedIndex.value == index ? colorBlueGrey : sideBarItemColor,
            ),
            child: Center(
              child: TextWidget(
                text: label, 
                color: controller.selectedIndex.value == index ? colorWhite : colorWhite,
                size: screenSize.width/100, 
                weight: FontWeight.w100
              ),
            ),
          )),
        ),
      ),
    );
  }
}