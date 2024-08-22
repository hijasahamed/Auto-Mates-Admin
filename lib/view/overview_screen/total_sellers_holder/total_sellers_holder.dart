import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalSellersHolder extends StatelessWidget {
  const TotalSellersHolder({super.key,required this.screenSize,required this.adminHomeScreenController,required this.totalSellerFontSize});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  final double totalSellerFontSize;
  @override
  Widget build(BuildContext context) {    
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(1),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(totalSellerFontSize/2),
          color: sideBarColor
        ),
        child: Padding(
          padding: EdgeInsets.all(totalSellerFontSize/2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'Total Sellers', color: colorWhite, size: totalSellerFontSize/2, weight: FontWeight.bold),
                  Icon(Icons.verified,color: Colors.green,size: totalSellerFontSize,)
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
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalSellerFontSize/2, weight: FontWeight.w500);
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalSellerFontSize/2, weight: FontWeight.w500);
                      }
                      final count = snapshot.data!.docs.length;
                      return TextWidget(text: count.toString(), color: colorWhite, size: totalSellerFontSize, weight: FontWeight.bold);
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