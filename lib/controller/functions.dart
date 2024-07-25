
import 'package:auto_mates_admin/view/admin_home_screen/admin_home_screen.dart';
import 'package:flutter/material.dart';

const String adminUserName = 'automatesadmin';
const String adminPassword = '123456789';

void loginAdmin ({required userPasswordController,required userNameController,context}){
  if(userNameController.text == adminUserName && userPasswordController.text == adminPassword){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AdminHomeScreen();
    },));
  }
}