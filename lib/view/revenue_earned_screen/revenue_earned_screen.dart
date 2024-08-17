import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/overview_screen/revenue_earned_holder/revenue_earned_holder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RevenueEarnedScreen extends StatelessWidget {
  const RevenueEarnedScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width/100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextWidget(text: 'Total Revenue', color: colorWhite, size: screenSize.width/60, weight: FontWeight.bold),
                SizedBox(width: screenSize.width/100,),
                TotalRevenueEarned(screenSize: screenSize,isRevenueScreen: true,),
              ],
            ),
            const Divider(),
            TextWidget(text: 'Payment History', color: colorWhite, size: screenSize.width/100, weight: FontWeight.bold),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('revenue').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: TextWidget(text: 'Something went wrong', color: colorWhite, size: screenSize.width/100, weight: FontWeight.bold),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: TextWidget(text: 'Something went wrong', color: colorWhite, size: screenSize.width/100, weight: FontWeight.bold),
                    );
                  }
              
                  final List<QueryDocumentSnapshot> revenueDocs = snapshot.data!.docs;
              
                  return ListView.builder(
                    itemCount: revenueDocs.length,
                    itemBuilder: (context, index) {
                      final data = revenueDocs[index].data() as Map<String, dynamic>;
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
                            title: TextWidget(text: 'Paid by: $paidBy', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w300),
                            subtitle: Row(
                              children: [
                                TextWidget(text: 'Paid for: $paidFor', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w300),
                                SizedBox(width: screenSize.width/100,),
                                TextWidget(text: 'Paid on: $paidDateTime', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w300),
                              ],
                            ),
                            trailing: TextWidget(text: 'Amount: ₹$amount', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w300),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}