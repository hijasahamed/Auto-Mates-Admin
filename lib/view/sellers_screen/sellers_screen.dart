import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/view/sellers_screen/seller_card_widget/seller_card_widget.dart';
import 'package:flutter/material.dart';

class SellersScreen extends StatelessWidget {
  const SellersScreen({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: EdgeInsets.all(screenSize.width/100),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: FirestoreService().streamAllSellers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: colorblue,));
            }
            if (snapshot.hasError) {
              return TextWidget(text: 'Error: ${snapshot.error}', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w500);
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return TextWidget(text: 'No verified sellers found', color: colorWhite, size: screenSize.width/100, weight: FontWeight.w500);
            }else{
              final sellers = snapshot.data!;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: screenSize.width / (screenSize.height / 1.5),
                ),
                itemCount: sellers.length,
                itemBuilder: (context, index) {
                  final seller = sellers[index];
                  return SellerCardWidget(
                    companyName: seller['companyName'],
                    location: seller['location'],
                    mobile: seller['mobile'],
                    sellerProfile: seller['sellerProfile'],
                    screenSize: screenSize,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}