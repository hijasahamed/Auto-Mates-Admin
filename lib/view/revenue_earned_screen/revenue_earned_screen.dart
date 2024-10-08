import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/overview_screen/holder_widgets/revenue_earned_holder/revenue_earned_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RevenueEarnedScreen extends StatelessWidget {
  const RevenueEarnedScreen({super.key, required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(
                    text: 'Total Revenue',
                    color: colorWhite,
                    size: screenSize.width / 60,
                    weight: FontWeight.bold),
                SizedBox(width: screenSize.width/100,),
                TotalRevenueEarned(
                  screenSize: screenSize,
                  isRevenueScreen: true,
                  totalRevenueFontSize: screenSize.width/60,
                ),
              ],
            ),
            const Divider(),
            TextWidget(
                text: 'Payment History',
                color: colorWhite,
                size: screenSize.width / 100,
                weight: FontWeight.bold),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('revenue')
                    .orderBy('paidDateTime', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: TextWidget(
                        text: 'Something went wrong',
                        color: colorWhite,
                        size: screenSize.width / 100,
                        weight: FontWeight.bold,
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: TextWidget(
                        text: 'No revenue data available',
                        color: colorWhite,
                        size: screenSize.width / 100,
                        weight: FontWeight.bold,
                      ),
                    );
                  }

                  final List<QueryDocumentSnapshot> revenueDocs = snapshot.data!.docs;

                  final Map<String, List<Map<String, dynamic>>>
                      groupedPayments = {
                    'Today': [],
                    'Yesterday': [],
                    'Earlier': [],
                  };

                  final today = DateTime.now();
                  final yesterday = today.subtract(const Duration(days: 1));

                  for (var doc in revenueDocs) {
                    final data = doc.data() as Map<String, dynamic>;
                    final paidDateTime = data['paidDateTime'] != null
                        ? (data['paidDateTime'] as Timestamp).toDate()
                        : null;

                    if (paidDateTime != null) {
                      if (isSameDate(paidDateTime, today)) {
                        groupedPayments['Today']!.add(data);
                      } else if (isSameDate(paidDateTime, yesterday)) {
                        groupedPayments['Yesterday']!.add(data);
                      } else {
                        groupedPayments['Earlier']!.add(data);
                      }
                    }
                  }

                  return ListView(
                    children: [
                      if (groupedPayments['Today']!.isNotEmpty)
                        buildPaymentGroup('Today', groupedPayments['Today']!),
                      if (groupedPayments['Yesterday']!.isNotEmpty)
                        buildPaymentGroup(
                            'Yesterday', groupedPayments['Yesterday']!),
                      if (groupedPayments['Earlier']!.isNotEmpty)
                        buildPaymentGroup(
                            'Earlier', groupedPayments['Earlier']!),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget buildPaymentGroup(String groupTitle, List<Map<String, dynamic>> payments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextWidget(
            text: groupTitle,
            color: colorWhite,
            size: screenSize.width / 50,
            weight: FontWeight.bold,
          ),
        ),
        ...payments.map((data) {
          final amount = data['amount'] ?? 0;
          final paidBy = data['paidBy'] ?? 'N/A';
          final paidFor = data['paidFor'] ?? 'N/A';
          final paidDateTime = data['paidDateTime'] != null
              ? (data['paidDateTime'] as Timestamp).toDate()
              : 'N/A';

          return Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              color: sideBarColor,
              child: ListTile(
                title: TextWidget(
                  text: 'Paid by: $paidBy',
                  color: colorWhite,
                  size: screenSize.width / 100,
                  weight: FontWeight.w300,
                ),
                subtitle: Row(
                  children: [
                    TextWidget(
                      text: 'Paid for: $paidFor',
                      color: colorWhite,
                      size: screenSize.width / 100,
                      weight: FontWeight.w300,
                    ),
                    SizedBox(width: screenSize.width / 100),
                    TextWidget(
                      text: 'Paid on: $paidDateTime',
                      color: colorWhite,
                      size: screenSize.width / 100,
                      weight: FontWeight.w300,
                    ),
                  ],
                ),
                trailing: TextWidget(
                  text: 'Amount: ₹$amount',
                  color: colorWhite,
                  size: screenSize.width / 100,
                  weight: FontWeight.w300,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}