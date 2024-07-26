import 'package:auto_mates_admin/view/admin_login_screen/admin_login_box/admin_login_button/admin_login_button.dart';
import 'package:auto_mates_admin/view/admin_login_screen/admin_login_box/admin_login_text_form/admin_login_text_form.dart';
import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AdminLoginBox extends StatelessWidget {
  const AdminLoginBox({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController userPasswordController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(text: 'Auto Mates', color: colorBlack, size: screenSize.width/40, weight: FontWeight.bold),
        SizedBox(height: screenSize.height/40,),
        Container(
          height: screenSize.height/1.5,
          width: screenSize.width/3.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(screenSize.width/100),
            color: colorWhite
          ),
          child: Padding(
            padding: EdgeInsets.all(screenSize.width/100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(text: 'Admin Login', color: colorBlueGrey, size: screenSize.width/60, weight: FontWeight.bold),
                AdminLoginTextForm(screenSize: screenSize,labelText: 'Username',prefixIcon: Icons.person,controller: userNameController,),
                AdminLoginTextForm(screenSize: screenSize,labelText: 'Password',prefixIcon: Icons.remove_red_eye,controller: userPasswordController,obscure: true,),
                SizedBox(height: screenSize.height/30,),
                AdminLoginButton(screenSize: screenSize,userNameController: userNameController,userPasswordController: userPasswordController,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}