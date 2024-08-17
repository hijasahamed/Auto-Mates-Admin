import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/sellers_screen/sellers_table/sellers_table.dart';
import 'package:auto_mates_admin/view/users_screen/next_previous_button/next_previous_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellersScreen extends StatelessWidget {
  const SellersScreen({super.key, required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    AdminSellerController adminSellerController =
        Get.put(AdminSellerController());
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
          padding: EdgeInsets.all(screenSize.width / 100),
          child: GetBuilder<AdminSellerController>(
            builder: (_) {
              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: FirestoreService().streamAllSellers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: colorblue,
                    ));
                  }
                  if (snapshot.hasError) {
                    return TextWidget(
                        text: 'Error: ${snapshot.error}',
                        color: colorWhite,
                        size: screenSize.width / 100,
                        weight: FontWeight.w500);
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return TextWidget(
                        text: 'No verified sellers found',
                        color: colorWhite,
                        size: screenSize.width / 100,
                        weight: FontWeight.w500);
                  } else {
                    final sellers = snapshot.data!;
                    final totalPages =(sellers.length / adminSellerController.rowsPerPage).ceil();
                    final displayedSellers = sellers
                        .skip((adminSellerController.currentPage.value *
                        adminSellerController.rowsPerPage)
                        .toInt())
                        .take(adminSellerController.rowsPerPage)
                        .toList();
                    return Column(
                      children: [
                        SellersTable(
                            screenSize: screenSize,
                            adminSellerController: adminSellerController,
                            totalPages: totalPages,
                            displayedSellers: displayedSellers),
                        NextPreviousButton(screenSize: screenSize, controller: adminSellerController, totalPages: totalPages)
                      ],
                    );
                  }
                },
              );
            },
          )),
    );
  }
}
