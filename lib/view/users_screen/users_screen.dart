import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key, required this.screenSize});
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width / 100),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: FirestoreService().streamAllUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: colorblue),
              );
            }
            if (snapshot.hasError) {
              return TextWidget(
                text: 'Error: ${snapshot.error}',
                color: colorWhite,
                size: screenSize.width / 100,
                weight: FontWeight.w500,
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return TextWidget(
                text: 'No users found',
                color: colorWhite,
                size: screenSize.width / 100,
                weight: FontWeight.w500,
              );
            } else {
              final users = snapshot.data!;
              return Container(
                decoration: BoxDecoration(
                  color: sideBarItemColor,
                  borderRadius: BorderRadius.circular(screenSize.width / 185),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Users',
                        color: colorWhite,
                        size: screenSize.width / 50,
                        weight: FontWeight.bold,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              dividerThickness: .1,
                              decoration: BoxDecoration(
                                border:
                                  Border.all(width: .4, color: colorWhite),
                              ),
                              columnSpacing: screenSize.width / 15,
                              headingRowColor:
                                  WidgetStateProperty.all(colorBlueGrey),
                              columns: [
                                DataColumn(
                                  label: TextWidget(
                                    text: 'User Name',
                                    color: colorWhite,
                                    size: screenSize.width / 100,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Location',
                                    color: colorWhite,
                                    size: screenSize.width / 100,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Contact',
                                    color: colorWhite,
                                    size: screenSize.width / 100,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Email',
                                    color: colorWhite,
                                    size: screenSize.width / 100,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                                DataColumn(
                                  label: TextWidget(
                                    text: 'Actions',
                                    color: colorWhite,
                                    size: screenSize.width / 100,
                                    weight: FontWeight.w500,
                                  ),
                                ),
                              ],
                              rows: users.map((user) {
                                return DataRow(
                                  cells: [
                                    DataCell(TextWidget(
                                      text: user['userName'] ?? '',
                                      color: colorWhite,
                                      size: screenSize.width / 100,
                                      weight: FontWeight.normal,
                                    )),
                                    DataCell(TextWidget(
                                      text: user['location'] ?? '',
                                      color: colorWhite,
                                      size: screenSize.width / 100,
                                      weight: FontWeight.normal,
                                    )),
                                    DataCell(TextWidget(
                                      text: user['mobile'] ?? '',
                                      color: colorWhite,
                                      size: screenSize.width / 100,
                                      weight: FontWeight.normal,
                                    )),
                                    DataCell(TextWidget(
                                      text: user['email'] ?? '',
                                      color: colorWhite,
                                      size: screenSize.width / 100,
                                      weight: FontWeight.normal,
                                    )),
                                    DataCell(
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  Colors.red),
                                        ),
                                        onPressed: () {
                                          Get.defaultDialog(
                                            title: 'Block User',
                                            middleText: 'Do you want to Block the user',
                                            backgroundColor: Colors.red
                                          );
                                        },
                                        child: TextWidget(
                                          text: 'Block',
                                          color: colorWhite,
                                          size: screenSize.width / 150,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


