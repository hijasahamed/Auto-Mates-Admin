import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NextPreviousButton extends StatelessWidget {
  const NextPreviousButton(
      {super.key,
      required this.screenSize,
      required this.adminUserController,
      required this.totalPages});
  final Size screenSize;
  final AdminUserController adminUserController;
  final int totalPages;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back,
                color: adminUserController.currentPage.value > 0
                    ? colorWhite
                    : Colors.grey),
            onPressed: adminUserController.currentPage.value > 0
                ? () {
                    adminUserController.previousPage();
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
            icon: Icon(Icons.arrow_forward,
                color: adminUserController.currentPage.value < totalPages - 1
                    ? colorWhite
                    : Colors.grey),
            onPressed: adminUserController.currentPage.value < totalPages - 1
                ? () {
                    adminUserController.nextPage();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
