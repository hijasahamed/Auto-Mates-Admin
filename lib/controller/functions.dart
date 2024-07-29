import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/firebase_controller.dart';
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen.dart';
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

void blockAndUnblockUsers({user,adminusercontroller}){
  Get.defaultDialog(
    title: adminusercontroller.isBlocked.value ? 'Unblock User' : 'Block User',
      middleText: adminusercontroller.isBlocked.value
          ? 'Do you want to unblock the user?'
          : 'Do you want to block the user?',
    backgroundColor: Colors.white,
    textCancel: 'Cancel',
    cancelTextColor: Colors.red,
    textConfirm: adminusercontroller.isBlocked.value ? 'Unblock' : 'Block',
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