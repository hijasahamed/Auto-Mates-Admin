import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen_side_bar/admin_home_screen_side_bar_item/admin_home_screen_side_bar_item.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminHomeScreenSideBar extends StatelessWidget {
  const AdminHomeScreenSideBar({super.key,required this.screenSize,required this.adminHomeScreenController});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: sideBarColor,
        child: Padding(
          padding: EdgeInsets.all(screenSize.width/100),
          child: ListView(
            children: [  
              Align(
                alignment: Alignment.center,
                child: TextWidget(text: 'AutoMates', color: colorWhite, size: screenSize.width/45, weight: FontWeight.w500)
              ),
              AdminHomeScreenSideBarItem(index: 0, label: 'Overview', controller: adminHomeScreenController,labelSize: screenSize.width/100,),
              AdminHomeScreenSideBarItem(index: 1, label: 'Total Sellers', controller: adminHomeScreenController,labelSize: screenSize.width/100,),
              AdminHomeScreenSideBarItem(index: 2, label: 'Total Users', controller: adminHomeScreenController,labelSize: screenSize.width/100,),
              AdminHomeScreenSideBarItem(index: 3, label: 'Total Revenue', controller: adminHomeScreenController,labelSize: screenSize.width/100,),
              AdminHomeScreenSideBarItem(index: 4, label: 'All Cars', controller: adminHomeScreenController,labelSize: screenSize.width/100,),
              AdminHomeScreenSideBarItem(index: 5, label: 'Sold Cars', controller: adminHomeScreenController,labelSize: screenSize.width/100,),
              AdminHomeScreenSideBarItem(index: 6, label: 'Featured Cars', controller: adminHomeScreenController,labelSize: screenSize.width/100,),
            ],
          ),
        ),
      )
    );
  }
}