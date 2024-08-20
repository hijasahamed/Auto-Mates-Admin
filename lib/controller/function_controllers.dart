import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String adminUserName = 'hijas';
const String adminPassword = '1234';

void loginAdmin ({required userPasswordController,required userNameController,context}){
  if(userNameController.text != adminUserName && userPasswordController.text == adminPassword){
    Get.snackbar('Username incorrect', 'Please provide the correct username',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      overlayBlur: 1,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal
    );
    userNameController.text= '';
  }
  else if(userPasswordController.text != adminPassword && userNameController.text == adminUserName){
    Get.snackbar('Password incorrect', 'Please provide the correct password',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      overlayBlur: 1,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal
    );
    userPasswordController.text = '';
  }
  else if(userNameController.text != adminUserName && userPasswordController.text != adminPassword){
    Get.snackbar('Wrong Username and Password', 'Provide a valid Username and Password',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      overlayBlur: 1,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal
    );
    userNameController.text='';
    userPasswordController.text = '';
  }
  else if (userPasswordController.text == null && userNameController.text ==null){
    Get.snackbar('Username and Password empty', 'Provide a valid Username and Password',
      backgroundColor: Colors.red,
      colorText: Colors.white,
      overlayBlur: 1,
      duration: const Duration(seconds: 2),
      dismissDirection: DismissDirection.horizontal
    );
  }
  else{
    Get.to(
      const AdminHomeScreen(),
      fullscreenDialog: true,
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 2000)
    );
    Get.snackbar('Login Successfull', 'Welcome back Admin',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      overlayBlur: 0,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1500),
      dismissDirection: DismissDirection.horizontal
    );
  }
}

void blockAndUnblockUsersAlertDialog({user,isUserBlocked}){
  Get.defaultDialog(
    title: isUserBlocked ? 'Unblock User' : 'Block User',
      middleText: isUserBlocked
          ? 'Do you want to unblock the user?'
          : 'Do you want to block the user?',
    backgroundColor: Colors.white,
    textCancel: 'Cancel',
    cancelTextColor: Colors.red,
    textConfirm: isUserBlocked ? 'Unblock' : 'Block',
    confirmTextColor: Colors.white,                                            
    onConfirm: () async {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('blocked_users')
          .where('userId', isEqualTo: user['id'])
          .get();
      if (querySnapshot.docs.isEmpty) {
        await FirestoreService().addUserToblockedList(user: user);
        await FirestoreService().blockAndRemoveUser(docId: user['id']);   
        Get.back();
      } else {
        await FirestoreService().addBlockedUserToUserList(user: user);
        await FirestoreService().removeBlockedUser(docId: user['id']);
        Get.back();
      }
    },
  );
}

void blockAndUnblockSellersAlertDialog({seller,isSellerBlocked}){
  Get.defaultDialog(
    title: isSellerBlocked ? 'Unblock Seller' : 'Block Seller',
      middleText: isSellerBlocked
          ? 'Do you want to unblock the seller?'
          : 'Do you want to block the seller?',
    backgroundColor: colorWhite,
    textCancel: 'Cancel',
    cancelTextColor: Colors.red,
    textConfirm: isSellerBlocked ? 'Unblock' : 'Block',
    confirmTextColor: Colors.white,                                            
    onConfirm: () async {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('blocked_sellers')
          .where('sellerId', isEqualTo: seller['id'])
          .get();
      if (querySnapshot.docs.isEmpty) {
        await FirestoreService().addSellerToBlockedList(seller: seller);
        await FirestoreService().blockAndRemoveSeller(docId: seller['id']);   
        Get.back();
      } else { 
        await FirestoreService().addBlockedSellersToSellersList(seller: seller);
        await FirestoreService().removeBlockedSellers(docId: seller['id']);      
        Get.back();
      }
    },
  );
}

void deleteCarToSellAlertDialog({car}){
  Get.defaultDialog(
    title: 'Remove This Car',
    middleText: 'Removing this car will Permenantly remove it.',
    backgroundColor: colorWhite,
    textCancel: 'Cancel',
    cancelTextColor: Colors.red,
    textConfirm: 'Delete',
    confirmTextColor: Colors.white,                                            
    onConfirm: () async {
      try {
        await FirebaseFirestore.instance
            .collection('carstosell')
            .doc(car.id)
            .delete();
        Get.back();
        Get.snackbar(
          'Success',
          'The car has been successfully deleted.',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to delete the car. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    },
  );
}