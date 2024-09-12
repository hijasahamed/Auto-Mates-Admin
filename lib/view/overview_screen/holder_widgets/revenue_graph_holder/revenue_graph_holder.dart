import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/model/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenuePieChartHolder extends StatelessWidget {
  const RevenuePieChartHolder({super.key,required this.screenSize});
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
        crossAxisAlignment: (Responsive.isDesktop(context) || Responsive.isTablet(context))? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisAlignment: (Responsive.isDesktop(context) || Responsive.isTablet(context))? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          FutureBuilder<Map<String, double>>(
            future: fetchRevenueData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: colorWhite,));
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
                  title: '',
                  titleStyle: const TextStyle(color: colorWhite),
                  value: entry.value
                );
              }).toList();
          
              if(Responsive.isDesktop(context) || Responsive.isTablet(context)){
                return Padding(
                  padding: EdgeInsets.all(screenSize.width/100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: screenSize.height/4,
                          child: PieChart(
                            PieChartData(
                              sections: pieSections,
                              borderData: FlBorderData(show: false),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: groupedData.entries.map((entry) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: screenSize.width/120),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenSize.width/100,
                                    height: screenSize.width/100,
                                    color: getColorForPaymentMethod(entry.key),
                                  ),
                                  SizedBox(width: screenSize.width/100),
                                  Expanded(
                                    child: Text(
                                      entry.key,
                                      style: TextStyle(color: getColorForPaymentMethod(entry.key), fontSize: screenSize.width/100),
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
                              padding: EdgeInsets.symmetric(vertical: screenSize.width/100),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenSize.width/100,
                                    height: screenSize.width/100,
                                    color: getColorForPaymentMethod(entry.key),
                                  ),
                                  SizedBox(width: screenSize.width/100),
                                  Expanded(
                                    child: Text(
                                      '₹${entry.value.toString()}',
                                      style: TextStyle(color: getColorForPaymentMethod(entry.key), fontSize: screenSize.width/100),
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
              }
              else{
                return Padding(
                  padding: EdgeInsets.all(screenSize.width/25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: screenSize.height/8,
                        child: PieChart(
                          PieChartData(
                            sections: pieSections,
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.width/25,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: groupedData.entries.map((entry) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: screenSize.width/30,
                                height: screenSize.width/30,
                                color: getColorForPaymentMethod(entry.key),
                              ),
                              SizedBox(width: screenSize.width/25),
                              Expanded(
                                child: Text(
                                  entry.key,
                                  style: TextStyle(color: getColorForPaymentMethod(entry.key), fontSize: screenSize.width/35),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: screenSize.width/25,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: groupedData.entries.map((entry) {
                          return Row(
                            children: [
                              Container(
                                width: screenSize.width/30,
                                height: screenSize.width/30,
                                color: getColorForPaymentMethod(entry.key),
                              ),
                              SizedBox(width: screenSize.width/25),
                              Expanded(
                                child: Text(
                                  '₹${entry.value.toString()}',
                                  style: TextStyle(color: getColorForPaymentMethod(entry.key), fontSize: screenSize.width/35),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      )
                    ],
                  ),
                );
              }

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
        return Colors.deepPurple;
      case 'Featuring Car':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}


