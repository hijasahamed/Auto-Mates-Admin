import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/users_screen/next_previous_button/next_previous_button.dart';
import 'package:auto_mates_admin/view/users_screen/users_table/users_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key, required this.screenSize});
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final AdminUserController adminUserController =
        Get.put(AdminUserController());
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width / 100),
        child: GetBuilder<AdminUserController>(
          builder: (_) {
            return StreamBuilder<List<Map<String, dynamic>>>(
              stream: FirestoreService().streamAllUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: colorblue),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: TextWidget(
                      text: 'Error: ${snapshot.error}',
                      color: colorWhite,
                      size: screenSize.width / 100,
                      weight: FontWeight.w500,
                    ),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: TextWidget(
                      text: 'No users found',
                      color: colorWhite,
                      size: screenSize.width / 100,
                      weight: FontWeight.w500,
                    ),
                  );
                } else {
                  final users = snapshot.data!;
                  final totalPages =
                      (users.length / adminUserController.rowsPerPage).ceil();
                  final displayedUsers = users
                      .skip((adminUserController.currentPage.value *
                              adminUserController.rowsPerPage)
                          .toInt())
                      .take(adminUserController.rowsPerPage)
                      .toList();
                  return Column(
                    children: [
                      UsersTable(
                          screenSize: screenSize,
                          adminUserController: adminUserController,
                          totalPages: totalPages,
                          displayedUsers: displayedUsers),
                      NextPreviousButton(
                          screenSize: screenSize,
                          adminUserController: adminUserController,
                          totalPages: totalPages)
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}