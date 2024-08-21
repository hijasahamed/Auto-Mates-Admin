import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllCarsToSellHolder extends StatelessWidget {
  const AllCarsToSellHolder({super.key,required this.screenSize,required this.adminHomeScreenController});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(4),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenSize.width/100),
          color: sideBarColor
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.width/100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'Total Cars To Sell', color: colorWhite, size: screenSize.width/100, weight: FontWeight.bold),
                  const Icon(Icons.car_rental_sharp,color: Colors.blue,)
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
                        return TextWidget(text: 'No documents found', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w500);
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w500);
                      }
                      final count = snapshot.data!.docs.length;
                      return TextWidget(text: count.toString(), color: colorWhite, size: screenSize.width/60, weight: FontWeight.bold);
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