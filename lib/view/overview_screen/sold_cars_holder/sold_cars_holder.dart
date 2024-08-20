import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SoldCarsHolder extends StatelessWidget {
  const SoldCarsHolder({super.key,required this.screenSize,required this.adminHomeScreenController});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(5),
      child: Ink(
        height: screenSize.height/5,
        width: screenSize.width/5,
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
                  TextWidget(text: 'Sold Cars', color: colorWhite, size: screenSize.width/100, weight: FontWeight.bold),
                  const Icon(Icons.check_circle, color: Colors.green)
                ],
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('soldcars').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(color: Colors.blue,);
                      }
                      if (snapshot.hasError) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w500);
                      }
                      if (!snapshot.hasData) {
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