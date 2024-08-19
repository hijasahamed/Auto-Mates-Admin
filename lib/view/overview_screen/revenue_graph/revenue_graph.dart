import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueGraph extends StatelessWidget {
  const RevenueGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('revenue').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No revenue data available'));
        }

        final revenueByMonth = <String, double>{};

        for (var doc in snapshot.data!.docs) {
          final amount = (doc['amount'] as num?)?.toDouble() ?? 0.0;
          final timestamp = (doc['paidDateTime'] as Timestamp?)?.toDate();
          if (timestamp != null) {
            final monthKey = DateFormat('MMM yyyy').format(timestamp);
            revenueByMonth.update(monthKey, (value) => value + amount,
                ifAbsent: () => amount);
          }
        }

        final spots = revenueByMonth.entries.map((entry) {
          final index =
              revenueByMonth.keys.toList().indexOf(entry.key).toDouble();
          final revenue = entry.value;
          return FlSpot(index, revenue);
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      return Text(
                        '₹${value.toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                    reservedSize: 40,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) {
                      final monthLabels = revenueByMonth.keys.toList();
                      if (value.toInt() < monthLabels.length) {
                        return Text(
                          monthLabels[value.toInt()],
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                      return const SizedBox();
                    },
                    interval: 1,
                    reservedSize: 60,
                  ),
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  barWidth: 3,
                  color: Colors.blueAccent,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.blue.withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: const FlDotData(show: true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
