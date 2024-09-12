import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllCarsToSellHolder extends StatelessWidget {
  const AllCarsToSellHolder({super.key,required this.screenSize,required this.adminHomeScreenController,required this.totalCarsToSellFontSize});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  final double totalCarsToSellFontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(4),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(totalCarsToSellFontSize/2),
          color: sideBarColor
        ),
        child: Padding(
          padding: EdgeInsets.all(totalCarsToSellFontSize/2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'Total Cars To Sell', color: colorWhite, size: totalCarsToSellFontSize/2, weight: FontWeight.bold),
                  Icon(Icons.car_rental_sharp,color: Colors.blue,size: totalCarsToSellFontSize,)
                ],
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('carstosell').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(color: Colors.blue,);
                      }
                      if (snapshot.hasError) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalCarsToSellFontSize/2, weight: FontWeight.w500);
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalCarsToSellFontSize/2, weight: FontWeight.w500);
                      }
                      final count = snapshot.data!.docs.length;
                      return TextWidget(text: count.toString(), color: colorWhite, size: totalCarsToSellFontSize, weight: FontWeight.bold);
                    },
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}