import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/overview_screen/all_cars_to_sell_holder/all_cars_to_sell_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/featured_cars_holder/featured_cars_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/revenue_earned_holder/revenue_earned_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/revenue_graph_holder/revenue_graph_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/sold_cars_holder/sold_cars_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/total_sellers_holder/total_sellers_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/total_users_holder/total_users_holder.dart';
import 'package:auto_mates_admin/view/responsive.dart';
import 'package:flutter/material.dart';


class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key, required this.screenSize, required this.adminHomeScreenController});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  @override
  Widget build(BuildContext context) {
    if(Responsive.isDesktop(context) || Responsive.isTablet(context)){
      return OverviewDesktopAndTablet(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController);
    }
    else{
      return Scaffold(
        backgroundColor: colorBlack,      
        body: Padding(
          padding: EdgeInsets.all(screenSize.width / 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Overview',
                color: colorWhite,
                size: screenSize.width / 25,
                weight: FontWeight.bold,
              ),
              SizedBox(height: screenSize.height / 50),
              SizedBox(
                height: screenSize.height/8,
                child: Row(
                  children: [
                    Expanded(child: TotalSellersHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalSellerFontSize: screenSize.width/17,)),
                    SizedBox(width: screenSize.width / 150),
                    Expanded(child: TotalUsersHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalUsersFontSize: screenSize.width/17,)),                    
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 50),
              SizedBox(
                height: screenSize.height/8,
                child: Row(
                  children: [
                    Expanded(child: RevenueEarnedHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalRevenueFontSize: screenSize.width/17,)),
                    SizedBox(width: screenSize.width / 150),
                    Expanded(child: AllCarsToSellHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalCarsToSellFontSize: screenSize.width/17,)),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 50),
              SizedBox(
                height: screenSize.height/8,
                child: Row(
                  children: [
                    Expanded(child: SoldCarsHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalSoldCarsFontSize: screenSize.width/17,)),
                    SizedBox(width: screenSize.width / 150),
                    Expanded(child: FeaturedCarsHolder(adminHomeScreenController: adminHomeScreenController, screenSize: screenSize,totalFeaturedCarsFontSize: screenSize.width/17,)),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height / 25),
              TextWidget(
                text: 'Revenue Chart',
                color: colorWhite,
                size: screenSize.width / 25,
                weight: FontWeight.bold,
              ),
              Expanded(child: RevenuePieChartHolder(screenSize: screenSize)),
            ],
          ),
        ),
      );
    }
  }
}



class OverviewDesktopAndTablet extends StatelessWidget {
  const OverviewDesktopAndTablet({
    super.key,
    required this.screenSize,
    required this.adminHomeScreenController,
  });

  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,      
      body: Padding(
        padding: EdgeInsets.all(screenSize.width / 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Overview',
              color: colorWhite,
              size: screenSize.width / 70,
              weight: FontWeight.bold,
            ),
            SizedBox(height: screenSize.height / 100),
            SizedBox(
              height: screenSize.height/5,
              child: Row(
                children: [
                  Expanded(child: TotalSellersHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalSellerFontSize: screenSize.width/60,)),
                  SizedBox(width: screenSize.width / 220),
                  Expanded(child: TotalUsersHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalUsersFontSize: screenSize.width/60,)),
                  SizedBox(width: screenSize.width / 220),
                  Expanded(child: RevenueEarnedHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalRevenueFontSize: screenSize.width/60,)),
                ],
              ),
            ),
            SizedBox(height: screenSize.height / 100),
            SizedBox(
              height: screenSize.height/5,
              child: Row(
                children: [
                  Expanded(child: AllCarsToSellHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalCarsToSellFontSize: screenSize.width/60,)),
                  SizedBox(width: screenSize.width / 220),
                  Expanded(child: SoldCarsHolder(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController,totalSoldCarsFontSize: screenSize.width/60,)),
                  SizedBox(width: screenSize.width / 220),
                  Expanded(child: FeaturedCarsHolder(adminHomeScreenController: adminHomeScreenController, screenSize: screenSize,totalFeaturedCarsFontSize: screenSize.width/60,)),
                ],
              ),
            ),
            SizedBox(height: screenSize.height / 25),
            TextWidget(
              text: 'Revenue Chart',
              color: colorWhite,
              size: screenSize.width / 80,
              weight: FontWeight.bold,
            ),
            Expanded(child: RevenuePieChartHolder(screenSize: screenSize)),
          ],
        ),
      ),
    );
  }
}