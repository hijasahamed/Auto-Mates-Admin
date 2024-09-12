import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen_side_bar/admin_home_screen_side_bar.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen_side_bar/admin_home_screen_side_bar_item/admin_home_screen_side_bar_item.dart';
import 'package:auto_mates_admin/view/all_car_to_sell_screen/all_car_to_sell_screen.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/featured_cars_screen/featured_cars_screen.dart';
import 'package:auto_mates_admin/model/responsive.dart';
import 'package:auto_mates_admin/view/revenue_earned_screen/revenue_earned_screen.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/overview_screen/overview_screen.dart';
import 'package:auto_mates_admin/view/sellers_screen/sellers_screen.dart';
import 'package:auto_mates_admin/view/sold_cars_screen/sold_cars_screen.dart';
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
      RevenueEarnedScreen(screenSize: screenSize,),
      AllCarToSellScreen(screenSize: screenSize),
      SoldCarsScreen(screenSize: screenSize,),
      FeaturedCarsScreen(screenSize: screenSize)
    ];
    return Scaffold(
      backgroundColor: colorBlack,
      drawer: Drawer(
        backgroundColor: sideBarColor,
        child: Padding(
          padding: EdgeInsets.all(screenSize.width/30),
          child: ListView(
              children: [  
                Align(
                  alignment: Alignment.center,
                  child: TextWidget(text: 'AutoMates', color: colorWhite, size: screenSize.width/45, weight: FontWeight.w500)
                ),
                AdminHomeScreenSideBarItem(index: 0, label: 'Overview', controller: adminHomeScreenController,labelSize: screenSize.width/25,isMobilescreen: true,),
                AdminHomeScreenSideBarItem(index: 1, label: 'Total Sellers', controller: adminHomeScreenController,labelSize: screenSize.width/25,isMobilescreen: true,),
                AdminHomeScreenSideBarItem(index: 2, label: 'Total Users', controller: adminHomeScreenController,labelSize: screenSize.width/25,isMobilescreen: true,),
                AdminHomeScreenSideBarItem(index: 3, label: 'Total Revenue', controller: adminHomeScreenController,labelSize: screenSize.width/25,isMobilescreen: true,),
                AdminHomeScreenSideBarItem(index: 4, label: 'All Cars', controller: adminHomeScreenController,labelSize: screenSize.width/25,isMobilescreen: true,),
                AdminHomeScreenSideBarItem(index: 5, label: 'Sold Cars', controller: adminHomeScreenController,labelSize: screenSize.width/25,isMobilescreen: true,),
                AdminHomeScreenSideBarItem(index: 6, label: 'Featured Cars', controller: adminHomeScreenController,labelSize: screenSize.width/25,isMobilescreen: true,),
              ],
            ),
        ),
      ),
      appBar: Responsive.isMobile(context) ? AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu, color: colorWhite),
            );
          },
        ),
        backgroundColor: colorBlack,
        centerTitle: true,
        title: TextWidget(text: 'Auto Mates', color: colorWhite, size: screenSize.width/25, weight: FontWeight.bold),
      ) : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isTablet(context) || Responsive.isDesktop(context))
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