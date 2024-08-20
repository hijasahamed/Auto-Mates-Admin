import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SoldCarsScreen extends StatelessWidget {
  const SoldCarsScreen({super.key, required this.screenSize});
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
              text: 'Sold Cars',
              color: colorWhite,
              size: screenSize.width / 60,
              weight: FontWeight.bold,
            ),
            SizedBox(height: screenSize.height / 40),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('soldcars').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: colorWhite,));
                  }
                  if (snapshot.hasError) {
                    return Center(child: TextWidget(text: 'Something went wrong', color: Colors.red, size: screenSize.width / 60,weight: FontWeight.bold,));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: TextWidget(text: 'No cars have been sold yet', color: colorWhite, size: screenSize.width / 60,weight: FontWeight.bold,));
                  }

                  final soldCars = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: soldCars.length,
                    itemBuilder: (context, index) {
                      final carData = soldCars[index].data() as Map<String, dynamic>;
                      return Card(
                        color: Colors.grey[850],
                        margin: EdgeInsets.symmetric(vertical: screenSize.height / 80),
                        child: ListTile(
                          title: Row(
                            children: [
                              TextWidget(
                                text: carData['brand'] ?? 'Unknown',
                                color: colorWhite,
                                size: screenSize.width / 70,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(width: screenSize.width/180,),
                              TextWidget(
                                text: carData['modelName'] ?? 'Unknown',
                                color: colorWhite,
                                size: screenSize.width / 80,
                                weight: FontWeight.w600,
                              ),
                              SizedBox(width: screenSize.width/120,),
                              TextWidget(
                                text: 'RegNo: ${carData['regNumber'] ?? 'Unknown'}',
                                color: colorWhite,
                                size: screenSize.width / 90,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              TextWidget(
                                text: 'Bought Price: ₹${carData['boughtPrice'] ?? 'N/A'}',
                                color: colorWhite,
                                size: screenSize.width / 120,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(width: screenSize.width/120,),
                              TextWidget(
                                text: 'Customer Price: ₹${carData['price'] ?? 'N/A'}',
                                color: colorWhite,
                                size: screenSize.width / 120,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(width: screenSize.width/120,),
                              TextWidget(
                                text: 'Sold for: ₹${carData['soldAmount'] ?? 'N/A'}',
                                color: colorWhite,
                                size: screenSize.width / 120,
                                weight: FontWeight.bold,
                              ),
                              SizedBox(width: screenSize.width/30,),
                              TextWidget(
                                text: 'Seller Profit ₹${carData['soldAmount'] - carData['boughtPrice']}',
                                color: colorWhite,
                                size: screenSize.width / 120,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.check_circle, color: Colors.green),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}