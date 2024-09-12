import 'package:auto_mates_admin/controller/function_controllers.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:auto_mates_admin/model/responsive.dart';
import 'package:flutter/material.dart';

class AdminLoginButton extends StatelessWidget {
  const AdminLoginButton({super.key,required this.screenSize,required this.userNameController,required this.userPasswordController});
  final Size screenSize;
  final TextEditingController userPasswordController;
  final TextEditingController userNameController;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: ()  {
            loginAdmin(userPasswordController: userPasswordController, userNameController: userNameController);           
          },
          child: Ink(
            height: Responsive.isDesktop(context) || Responsive.isTablet(context)? screenSize.height/14 : screenSize.height/25,
            width: screenSize.width/4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenSize.width/200),
              color: Colors.blueGrey
            ),
            child: Center(
              child: TextWidget(
                text: 'Login',
                color: Colors.white,
                size: Responsive.isDesktop(context) || Responsive.isTablet(context)?screenSize.width/85 : screenSize.width/40,
                weight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
  }
}