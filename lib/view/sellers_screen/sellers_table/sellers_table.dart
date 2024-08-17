import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/sellers_screen/sellers_block_unblock_button/sellers_block_unblock_button.dart';
import 'package:flutter/material.dart';

class SellersTable extends StatelessWidget {
  const SellersTable(
      {super.key,
      required this.screenSize,
      required this.adminSellerController,
      required this.totalPages,
      required this.displayedSellers});
  final Size screenSize;
  final AdminSellerController adminSellerController;
  final int totalPages;
  final List<Map<String, dynamic>> displayedSellers;
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                text: 'Sellers',
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
                      columnSpacing: screenSize.width / 12,
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
                            text: 'Seller Name',
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
                            text: 'Subscription',
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
                      rows: List<DataRow>.generate(displayedSellers.length,
                          (index) {
                        final seller = displayedSellers[index];
                        final serialNumber =
                            (adminSellerController.currentPage.value *
                                    adminSellerController.rowsPerPage +
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
                              text: seller['companyName'] ?? '',
                              color: colorWhite,
                              size: screenSize.width / 100,
                              weight: FontWeight.normal,
                            )),
                            DataCell(TextWidget(
                              text: seller['location'] ?? '',
                              color: colorWhite,
                              size: screenSize.width / 100,
                              weight: FontWeight.normal,
                            )),
                            DataCell(TextWidget(
                              text: seller['mobile'] ?? '',
                              color: colorWhite,
                              size: screenSize.width / 100,
                              weight: FontWeight.normal,
                            )),
                            DataCell(TextWidget(
                              text: seller['plan'] == 'subscribed' ? 'Subscribed' : 'UnSubscribed',
                              color: seller['plan'] == 'subscribed' ? Colors.green : Colors.red,
                              size: screenSize.width / 100,
                              weight: FontWeight.w500,
                            )),
                            DataCell(SellersBlockUnblockButton(screenSize: screenSize,seller: seller,))
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