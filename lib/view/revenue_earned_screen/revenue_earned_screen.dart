import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/overview_screen/revenue_earned_holder/revenue_earned_holder.dart';
import 'package:flutter/material.dart';

class RevenueEarnedScreen extends StatelessWidget {
  const RevenueEarnedScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width/100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(text: 'Total Revenue', color: colorWhite, size: screenSize.width/60, weight: FontWeight.bold),
                TotalRevenueEarned(screenSize: screenSize,isRevenueScreen: true,),
              ],
            ),
            const Divider(),
            TextWidget(text: 'Payment History', color: colorWhite, size: screenSize.width/100, weight: FontWeight.bold),
            Expanded(
              child: Container(
                color: Colors.green,
              )
            )
          ],
        ),
      ),
    );
  }
}