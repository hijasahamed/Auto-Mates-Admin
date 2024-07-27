import 'package:auto_mates_admin/controller/admin_home_screen_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalSellersHolder extends StatelessWidget {
  const TotalSellersHolder({super.key,required this.screenSize,required this.controller});
  final Size screenSize;
  final AdminHomeScreenController controller;
  @override
  Widget build(BuildContext context) {    
    return InkWell(
      onTap: () => controller.changePage(1),
      child: Ink(
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
                  TextWidget(text: 'Total Sellers', color: colorBlueGrey, size: screenSize.width/100, weight: FontWeight.bold),
                  const Icon(Icons.verified,color: Colors.green,)
                ],
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('sellerSignupData').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(color: Colors.blue,);
                      }
                      if (snapshot.hasError) {
                        return TextWidget(text: 'No documents found', color: colorBlueGrey, size: screenSize.width/100, weight: FontWeight.w500);
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return TextWidget(text: 'No documents found', color: colorBlueGrey, size: screenSize.width/100, weight: FontWeight.w500);
                      }
                      final count = snapshot.data!.docs.length;
                      return TextWidget(text: count.toString(), color: Colors.grey, size: screenSize.width/30, weight: FontWeight.bold);
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