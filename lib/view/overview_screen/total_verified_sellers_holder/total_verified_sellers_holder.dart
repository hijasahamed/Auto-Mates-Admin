import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TotalVerifiedSellersHolder extends StatelessWidget {
  const TotalVerifiedSellersHolder({super.key,required this.screenSize});
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
                TextWidget(text: 'Total Verified Sellers', color: colorBlueGrey, size: screenSize.width/100, weight: FontWeight.bold),
                const Icon(Icons.verified,color: Colors.green,)
              ],
            ),
            // Expanded(
            //   child: Center(
            //     child: StreamBuilder<QuerySnapshot>(
            //       stream: ,
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return CircularProgressIndicator();
            //         }
            //         if (snapshot.hasError) {
            //           return Text('Error: ${snapshot.error}');
            //         }
            //         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //           return Text('No documents found');
            //         }
            //         final count = snapshot.data!.docs.length;
            //         return TextWidget(text: count, color: Colors.grey, size: screenSize.width/30, weight: FontWeight.bold);
            //       },
            //     ),
            //   )
            // )
          ],
        ),
      ),
    );
  }
}