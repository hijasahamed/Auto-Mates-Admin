import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TotalUsersHolder extends StatelessWidget {
  const TotalUsersHolder({super.key,required this.screenSize,required this.adminHomeScreenController});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(2),
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
                  TextWidget(text: 'Total Users', color: colorBlueGrey, size: screenSize.width/100, weight: FontWeight.bold),
                  const Icon(Icons.person,color: Colors.blue,)
                ],
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('userSignupData').snapshots(),
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