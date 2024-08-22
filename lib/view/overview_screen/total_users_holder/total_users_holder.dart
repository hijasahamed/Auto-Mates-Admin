import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class TotalUsersHolder extends StatelessWidget {
  const TotalUsersHolder({super.key,required this.screenSize,required this.adminHomeScreenController,required this.totalUsersFontSize});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  final double totalUsersFontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(2),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(totalUsersFontSize/2),
          color: sideBarColor
        ),
        child: Padding(
          padding: EdgeInsets.all(totalUsersFontSize/2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: 'Total Users', color: colorWhite, size: totalUsersFontSize/2, weight: FontWeight.bold),
                  Icon(Icons.person,color: Colors.blue,size: totalUsersFontSize,)
                ],
              ),
              Expanded(
                child: Center(
                  child: StreamBuilder<int>(
                    stream: FirestoreService().streamAllUsersCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(color: Colors.blue,);
                      }
                      if (snapshot.hasError) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalUsersFontSize/2, weight: FontWeight.w500);
                      }
                      if (!snapshot.hasData) {
                        return TextWidget(text: 'No documents found', color: colorWhite, size: totalUsersFontSize/2, weight: FontWeight.w500);
                      }
                      final count = snapshot.data!;
                      return TextWidget(text: count.toString(), color: colorWhite, size: totalUsersFontSize, weight: FontWeight.bold);
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