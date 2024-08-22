import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/users_screen/block_unblock_button/block_unblock_button.dart';
import 'package:flutter/material.dart';

class UsersTable extends StatelessWidget {
  const UsersTable(
      {super.key,
      required this.screenSize,
      required this.adminUserController,
      required this.totalPages,
      required this.displayedUsers});
  final Size screenSize;
  final AdminUserController adminUserController;
  final int totalPages;
  final List<Map<String, dynamic>> displayedUsers;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 95,
      child: Container(
        decoration: BoxDecoration(
          color: sideBarColor,
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
                      columnSpacing: screenSize.width / 17,
                      headingRowColor: WidgetStateProperty.all(colorBlueGrey),
                      columns: [
                        DataColumn(
                          label: TextWidget(
                            text: 'S.No',
                            color: colorWhite,
                            size: screenSize.width / 100,
                            weight: FontWeight.w500,
                          ),
                        ),
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
                      rows: List<DataRow>.generate(displayedUsers.length,
                          (index) {
                        final user = displayedUsers[index];
                        final serialNumber =
                            (adminUserController.currentPage.value *
                                    adminUserController.rowsPerPage +
                                index +
                                1);
                        return DataRow(
                          cells: [
                            DataCell(TextWidget(
                              text: serialNumber.toString(),
                              color: colorWhite,
                              size: screenSize.width / 100,
                              weight: FontWeight.normal,
                            )),
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
                            DataCell(BlockUnblockButton(user: user,screenSize: screenSize,)),
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
    );
  }
}
