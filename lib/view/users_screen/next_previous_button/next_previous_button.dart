import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NextPreviousButton extends StatelessWidget {
  const NextPreviousButton(
      {super.key,
      required this.screenSize,
      required this.controller,
      required this.totalPages});
  final Size screenSize;
  final dynamic controller;
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
                color: controller.currentPage.value > 0
                    ? colorWhite
                    : Colors.grey),
            onPressed: controller.currentPage.value > 0
                ? () {
                    controller.previousPage();
                  }
                : null,
          ),
          TextWidget(
            text: '${controller.currentPage.value + 1} / $totalPages',
            color: colorWhite,
            size: screenSize.width / 100,
            weight: FontWeight.w500,
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward,
                color: controller.currentPage.value < totalPages - 1
                    ? colorWhite
                    : Colors.grey),
            onPressed: controller.currentPage.value < totalPages - 1
                ? () {
                    controller.nextPage();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
