import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueEarnedHolder extends StatelessWidget {
  const RevenueEarnedHolder({
    super.key,
    required this.screenSize,
    required this.adminHomeScreenController,
  });

  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => adminHomeScreenController.changePage(3),
      child: Ink(
        height: screenSize.height / 5,
        width: screenSize.width / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenSize.width / 100),
          color: sideBarColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(screenSize.width / 100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Revenue Earned',
                    color: colorWhite,
                    size: screenSize.width / 100,
                    weight: FontWeight.bold,
                  ),
                  const Icon(
                    Icons.currency_rupee_sharp,
                    color: Colors.green,
                  ),
                ],
              ),
              TotalRevenueEarned(screenSize: screenSize),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalRevenueEarned extends StatelessWidget {
  const TotalRevenueEarned({
    super.key,
    required this.screenSize,
    this.isRevenueScreen,
  });

  final Size screenSize;
  final bool? isRevenueScreen;

  @override
  Widget build(BuildContext context) {
    Widget revenueWidget = StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('revenue').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: Colors.blue);
        }
        if (snapshot.hasError) {
          return TextWidget(
            text: 'No documents found',
            color: colorWhite,
            size: screenSize.width / 100,
            weight: FontWeight.w500,
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return TextWidget(
            text: '0',
            color: colorWhite,
            size: screenSize.width / 30,
            weight: FontWeight.w500,
          );
        }
        final totalAmount = snapshot.data!.docs
            .map((doc) => (doc['amount'] as num?) ?? 0)
            .reduce((value, element) => value + element);
        final formattedAmount = NumberFormat.decimalPattern('en_IN').format(totalAmount);
        return TextWidget(
          text: '₹${formattedAmount.toString()}',
          color: (isRevenueScreen == true) ? Colors.green : colorWhite,
          size: screenSize.width / 60,
          weight: FontWeight.bold,
        );
      },
    );

    if (isRevenueScreen == true) {
      return revenueWidget;
    }

    return Expanded(
      child: Center(child: revenueWidget),
    );
  }
}
