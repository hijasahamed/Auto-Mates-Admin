import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/overview_screen/total_verified_sellers_holder/total_verified_sellers_holder.dart';
import 'package:auto_mates_admin/view/overview_screen/unverified_sellers_holder/unverified_sellers_holder.dart';
import 'package:flutter/material.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width/50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(text: 'Overview', color: colorWhite, size: screenSize.width/70, weight: FontWeight.bold),
            SizedBox(height: screenSize.height/100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalVerifiedSellersHolder(screenSize: screenSize),
                UnverifiedSellersHolder(screenSize: screenSize),
                Container(
                  height: screenSize.height/5,
                  width: screenSize.width/5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenSize.width/100),
                    color: colorBlueGrey
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