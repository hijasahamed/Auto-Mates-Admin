import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/function_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellersBlockUnblockButton extends StatelessWidget {
  SellersBlockUnblockButton({super.key,required this.screenSize,required this.seller});
  final Map<String, dynamic> seller;
  final Size screenSize;
  final AdminSellerController adminSellerController = Get.put(AdminSellerController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: adminSellerController.sellerBlockStatusStream(sellerId: seller['id']), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
        }
        bool isSellerBlocked = snapshot.data ?? false;
        return TextButton(        
          onPressed: () {
            blockAndUnblockSellersAlertDialog(isSellerBlocked: isSellerBlocked,seller: seller);
          },
          child: Text(
            isSellerBlocked ? 'Unblock' : 'Block',
            style: TextStyle(
              color: isSellerBlocked ? Colors.green : Colors.red,
              fontSize: screenSize.width / 100,
              fontWeight: FontWeight.w600,
            ),
          ),
        );  
      },
    );
  }
}