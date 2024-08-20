import 'package:auto_mates_admin/controller/function_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class FeaturedCarsScreen extends StatelessWidget {
  const FeaturedCarsScreen({super.key, required this.screenSize});
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
            TextWidget(
              text: 'Featured Cars',
              color: colorWhite,
              size: screenSize.width / 60,
              weight: FontWeight.bold,
            ),
            SizedBox(height: screenSize.height / 100),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('featuredCars')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: colorWhite,));
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red)));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text('No featured cars available',
                          style: TextStyle(color: colorWhite)));
                }

                final featuredCars = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: featuredCars.length,
                    itemBuilder: (context, index) {
                      final car = featuredCars[index];
                      final carData = featuredCars[index].data() as Map<String, dynamic>;
                      
                      DateTime startDate = DateTime.parse(
                          carData['startDate'].toDate().toString());
                      DateTime endDate = DateTime.parse(
                          carData['endDate'].toDate().toString());

                      int daysLeft = endDate.difference(DateTime.now()).inDays;

                      String formattedYear = DateFormat.y().format(startDate);

                      return Card(
                        color: Colors.grey[850],
                        margin: EdgeInsets.symmetric(
                            vertical: screenSize.height / 80),
                        child: ListTile(
                          title: Row(
                            children: [
                              TextWidget(
                                text: carData['brand'] ?? 'Unknown',
                                color: colorWhite,
                                size: screenSize.width / 70,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(width: screenSize.width / 180),
                              TextWidget(
                                text: carData['modelName'] ?? 'Unknown',
                                color: colorWhite,
                                size: screenSize.width / 80,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(width: screenSize.width / 120),
                              TextWidget(
                                text:
                                    'RegNo: ${carData['regNumber'] ?? 'Unknown'}',
                                color: colorWhite,
                                size: screenSize.width / 90,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextWidget(
                                    text:
                                        'Price: ₹${carData['price'] ?? 'N/A'}',
                                    color: colorWhite,
                                    size: screenSize.width / 120,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(width: screenSize.width / 120),
                                  TextWidget(
                                    text: 'Year: $formattedYear',
                                    color: colorWhite,
                                    size: screenSize.width / 120,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              TextWidget(
                                text: 'Days Left: $daysLeft days',
                                color: colorWhite,
                                size: screenSize.width / 120,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              deleteFeaturedCar(car: car);
                            }, 
                            icon: const Icon(Icons.more_vert,color: colorWhite,)
                          )
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
