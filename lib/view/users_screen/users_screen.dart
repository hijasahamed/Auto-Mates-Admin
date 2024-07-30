import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/users_screen/blocked_screen/block_unblock_button/block_unblock_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key, required this.screenSize});
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    final AdminUserController adminUserController = Get.put(AdminUserController());
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
              final totalPages = (users.length / adminUserController.rowsPerPage).ceil();
              final displayedUsers = users
              .skip((adminUserController.currentPage.value * adminUserController.rowsPerPage).toInt())
              .take(adminUserController.rowsPerPage)
              .toList();
              return Column(
                children: [
                  Expanded(
                    flex: 95,
                    child: Container(
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
                                      border: Border.all(width: .4, color: colorWhite),
                                    ),
                                    columnSpacing: screenSize.width / 15,
                                    headingRowColor: WidgetStateProperty.all(colorBlueGrey),
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
                                    rows: displayedUsers.map((user) {
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
                                          DataCell(BlockUnblockButton(user: user)),
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
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: adminUserController.currentPage.value > 0 ? colorWhite : Colors.grey),
                          onPressed: adminUserController.currentPage.value > 0
                              ? () {
                                  adminUserController.currentPage--;
                                }
                              : null,
                        ),
                        TextWidget(
                          text: '${adminUserController.currentPage.value + 1} / $totalPages',
                          color: colorWhite,
                          size: screenSize.width / 100,
                          weight: FontWeight.w500,
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: adminUserController.currentPage.value < totalPages - 1 ? colorWhite : Colors.grey),
                          onPressed: adminUserController.currentPage.value < totalPages - 1
                              ? () {
                                  adminUserController.currentPage++;
                                }
                              : null,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

// import 'package:auto_mates_admin/controller/firebase_controller.dart';
// import 'package:auto_mates_admin/view/common_widgets/colors.dart';
// import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
// import 'package:auto_mates_admin/view/users_screen/blocked_screen/block_unblock_button/block_unblock_button.dart';
// import 'package:flutter/material.dart';

// class UsersScreen extends StatefulWidget {
//   const UsersScreen({super.key, required this.screenSize});
//   final Size screenSize;

//   @override
//   _UsersScreenState createState() => _UsersScreenState();
// }

// class _UsersScreenState extends State<UsersScreen> {
//   int currentPage = 0;
//   final int rowsPerPage = 13;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorBlack,
//       body: Padding(
//         padding: EdgeInsets.all(widget.screenSize.width / 100),
//         child: StreamBuilder<List<Map<String, dynamic>>>(
//           stream: FirestoreService().streamAllUsers(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(color: colorblue),
//               );
//             }
//             if (snapshot.hasError) {
//               return Center(
//                 child: TextWidget(
//                   text: 'Error: ${snapshot.error}',
//                   color: colorWhite,
//                   size: widget.screenSize.width / 100,
//                   weight: FontWeight.w500,
//                 ),
//               );
//             }
//             if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(
//                 child: TextWidget(
//                   text: 'No users found',
//                   color: colorWhite,
//                   size: widget.screenSize.width / 100,
//                   weight: FontWeight.w500,
//                 ),
//               );
//             } else {
//               final users = snapshot.data!;
//               final totalPages = (users.length / rowsPerPage).ceil();

//               final displayedUsers = users.skip(currentPage * rowsPerPage).take(rowsPerPage).toList();

//               return Column(
//                 children: [
//                   Expanded(
//                     flex: 95,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: sideBarItemColor,
//                         borderRadius: BorderRadius.circular(widget.screenSize.width / 185),
//                       ),
//                       child: Padding(
//                         padding: EdgeInsets.all(widget.screenSize.width / 100),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextWidget(
//                               text: 'Users',
//                               color: colorWhite,
//                               size: widget.screenSize.width / 50,
//                               weight: FontWeight.bold,
//                             ),
//                             Expanded(
//                               child: SingleChildScrollView(
//                                 child: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: DataTable(
//                                     dividerThickness: .1,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(width: .4, color: colorWhite),
//                                     ),
//                                     columnSpacing: widget.screenSize.width / 15,
//                                     headingRowColor: MaterialStateProperty.all(colorBlueGrey),
//                                     columns: [
//                                       DataColumn(
//                                         label: TextWidget(
//                                           text: 'User Name',
//                                           color: colorWhite,
//                                           size: widget.screenSize.width / 100,
//                                           weight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       DataColumn(
//                                         label: TextWidget(
//                                           text: 'Location',
//                                           color: colorWhite,
//                                           size: widget.screenSize.width / 100,
//                                           weight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       DataColumn(
//                                         label: TextWidget(
//                                           text: 'Contact',
//                                           color: colorWhite,
//                                           size: widget.screenSize.width / 100,
//                                           weight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       DataColumn(
//                                         label: TextWidget(
//                                           text: 'Email',
//                                           color: colorWhite,
//                                           size: widget.screenSize.width / 100,
//                                           weight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       DataColumn(
//                                         label: TextWidget(
//                                           text: 'Actions',
//                                           color: colorWhite,
//                                           size: widget.screenSize.width / 100,
//                                           weight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                     rows: displayedUsers.map((user) {
//                                       return DataRow(
//                                         cells: [
//                                           DataCell(TextWidget(
//                                             text: user['userName'] ?? '',
//                                             color: colorWhite,
//                                             size: widget.screenSize.width / 100,
//                                             weight: FontWeight.normal,
//                                           )),
//                                           DataCell(TextWidget(
//                                             text: user['location'] ?? '',
//                                             color: colorWhite,
//                                             size: widget.screenSize.width / 100,
//                                             weight: FontWeight.normal,
//                                           )),
//                                           DataCell(TextWidget(
//                                             text: user['mobile'] ?? '',
//                                             color: colorWhite,
//                                             size: widget.screenSize.width / 100,
//                                             weight: FontWeight.normal,
//                                           )),
//                                           DataCell(TextWidget(
//                                             text: user['email'] ?? '',
//                                             color: colorWhite,
//                                             size: widget.screenSize.width / 100,
//                                             weight: FontWeight.normal,
//                                           )),
//                                           DataCell(BlockUnblockButton(user: user)),
//                                         ],
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: widget.screenSize.height * 0.05,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.arrow_back, color: currentPage > 0 ? colorWhite : Colors.grey),
//                           onPressed: currentPage > 0
//                               ? () {
//                                   setState(() {
//                                     print(currentPage);
//                                     currentPage--;
//                                     print(currentPage);
//                                   });
//                                 }
//                               : null,
//                         ),
//                         TextWidget(
//                           text: '${currentPage + 1} / $totalPages',
//                           color: colorWhite,
//                           size: widget.screenSize.width / 100,
//                           weight: FontWeight.w500,
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_forward, color: currentPage < totalPages - 1 ? colorWhite : Colors.grey),
//                           onPressed: currentPage < totalPages - 1
//                               ? () {
//                                   setState(() {
//                                     print(currentPage);
//                                     currentPage++;
//                                     print(currentPage);
//                                   });
//                                 }
//                               : null,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
