import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/overview_screen/revenue_earned_holder/revenue_earned_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/total_sellers_holder/total_sellers_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/total_users_holder/total_users_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key,required this.screenSize,required this.adminHomeScreenController});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width/50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: 'Overview', color: colorWhite, size: screenSize.width/70, weight: FontWeight.w500),
            const Divider(color: Colors.grey,),
            SizedBox(height: screenSize.height/100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalSellersHolder(screenSize: screenSize,adminHomeScreenController: adminHomeScreenController,),
                TotalUsersHolder(screenSize: screenSize,adminHomeScreenController: adminHomeScreenController,),
                RevenueEarnedHolder(screenSize: screenSize,adminHomeScreenController: adminHomeScreenController,),
              ],
            ),
          ],
        ),
      )
    );
  }
}