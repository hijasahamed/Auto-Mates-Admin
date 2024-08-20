import 'package:auto_mates_admin/controller/function_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllCarToSellScreen extends StatelessWidget {
  const AllCarToSellScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(screenSize.width / 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'All Cars',
            color: colorWhite,
            size: screenSize.width / 60,
            weight: FontWeight.bold,
          ),
          SizedBox(height: screenSize.height / 50),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('carstosell').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: colorWhite,),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No cars available to display'),
                  );
                }

                final cars = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    final car = cars[index];
                    return Card(
                      color: Colors.grey[850],
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Row(
                          children: [
                            TextWidget(text: car['brand'], color: colorWhite, size: screenSize.width/80, weight: FontWeight.bold),
                            SizedBox(width: screenSize.width/180,),
                            TextWidget(text: car['modelName'], color: colorWhite, size: screenSize.width/100, weight: FontWeight.bold),
                          ],
                        ),
                        subtitle: Row(
                          children: [                            
                            TextWidget(text: 'Price: ₹${car['price']}', color: Colors.grey, size: screenSize.width / 90, weight: FontWeight.bold),
                            SizedBox(width: screenSize.width/150,),
                            TextWidget(text: 'Seller: ${car['sellerName']}', color: Colors.grey, size: screenSize.width / 90, weight: FontWeight.bold),
                          ],
                        ),
                        leading: Icon(
                          Icons.directions_car,
                          color: Colors.blueAccent,
                          size: screenSize.width / 50,
                        ),
                        trailing: TextButton(
                          onPressed: () {
                            deleteCarToSellAlertDialog(car: car);
                          }, 
                          child: TextWidget(text: 'Remove', color: colorWhite, size: screenSize.width/120, weight: FontWeight.bold)
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}