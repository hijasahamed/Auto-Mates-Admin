import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class UnverifiedSellersHolder extends StatelessWidget {
  const UnverifiedSellersHolder({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height/5,
      width: screenSize.width/5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenSize.width/100),
        color: colorWhite
      ),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width/100),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: 'Unverified Sellers', color: colorBlueGrey, size: screenSize.width/100, weight: FontWeight.bold),
                const Icon(Icons.safety_check,color: Colors.blue,)
              ],
            ),
            Expanded(
              child: Center(child: TextWidget(text: '3', color: Colors.grey, size: screenSize.width/30, weight: FontWeight.bold))
            )
          ],
        ),
      ),
    );
  }
}