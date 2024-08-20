import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenuePieChart extends StatelessWidget {
  const RevenuePieChart({super.key,required this.screenSize});
  final Size screenSize;
  Future<Map<String, double>> fetchRevenueData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('revenue').get();

    Map<String, double> groupedData = {};

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      final paymentMethod = data['paidFor'] as String? ?? 'Unknown';
      final amount = (data['amount'] as num?)?.toDouble() ?? 0.0;

      if (groupedData.containsKey(paymentMethod)) {
        groupedData[paymentMethod] = groupedData[paymentMethod]! + amount;
      } else {
        groupedData[paymentMethod] = amount;
      }
    }
    return groupedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Column(
        children: [
          TextWidget(text: 'Revenue Chart', color: colorWhite, size: screenSize.width/80, weight: FontWeight.bold),
          FutureBuilder<Map<String, double>>(
            future: fetchRevenueData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
          
              if (snapshot.hasError) {
                return const Center(child: Text('Error loading revenue data'));
              }
          
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No revenue data available'));
              }
          
              final groupedData = snapshot.data!;
              List<PieChartSectionData> pieSections = groupedData.entries.map((entry) {
                return PieChartSectionData(
                  color: getColorForPaymentMethod(entry.key),
                );
              }).toList();
          
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: pieSections,
                            centerSpaceRadius: 30,
                            sectionsSpace: 2,
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: groupedData.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: getColorForPaymentMethod(entry.key),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    entry.key,
                                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: groupedData.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: getColorForPaymentMethod(entry.key),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '₹${entry.value.toString()}',
                                    style: const TextStyle(color: Colors.blue, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color getColorForPaymentMethod(String method) {
    switch (method.toString()) {
      case 'Marking Interest':
        return Colors.blue;
      case 'Seller Premium Subscription':
        return Colors.green;
      case 'Featuring Car':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}


