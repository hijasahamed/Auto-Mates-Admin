import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen.dart';
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