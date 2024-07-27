import 'package:auto_mates_admin/controller/admin_home_screen_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/overview_screen/total_sellers_holder/total_sellers_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/total_users_holder/total_users_holder.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key,required this.screenSize,required this.controller});
  final Size screenSize;
  final AdminHomeScreenController controller;
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
                TotalSellersHolder(screenSize: screenSize,controller: controller,),
                TotalUsersHolder(screenSize: screenSize,controller: controller,),
                Container(
                  height: screenSize.height/5,
                  width: screenSize.width/5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenSize.width/100),
                    color: colorWhite
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}