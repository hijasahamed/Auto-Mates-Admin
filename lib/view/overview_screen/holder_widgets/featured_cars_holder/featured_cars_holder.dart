import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeaturedCarsHolder extends StatelessWidget {
  const FeaturedCarsHolder({super.key,required this.adminHomeScreenController,required this.screenSize,required this.totalFeaturedCarsFontSize});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  final double totalFeaturedCarsFontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(6),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(totalFeaturedCarsFontSize/2),
          color: sideBarColor
        ),
        child: Padding(
          padding: EdgeInsets.all(totalFeaturedCarsFontSize/2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'Featured Cars', color: colorWhite, size: totalFeaturedCarsFontSize/2, weight: FontWeight.bold),
                  Icon(Icons.payments,color: Colors.green,size: totalFeaturedCarsFontSize,)
                ],
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('featuredCars').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(color: Colors.blue,);
                      }
                      if (snapshot.hasError) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalFeaturedCarsFontSize/2, weight: FontWeight.w500);
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalFeaturedCarsFontSize/2, weight: FontWeight.w500);
                      }
                      final count = snapshot.data!.docs.length;
                      return TextWidget(text: count.toString(), color: colorWhite, size: totalFeaturedCarsFontSize, weight: FontWeight.bold);
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