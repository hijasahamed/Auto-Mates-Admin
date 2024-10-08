import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/model/responsive.dart';
import 'package:flutter/material.dart';

class AdminLoginTextForm extends StatelessWidget {
  const AdminLoginTextForm({
    super.key,
    required this.labelText,
    required this.screenSize,
    required this.prefixIcon,
    required this.controller,
    this.obscure
    });
    final Size screenSize;
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool? obscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.isDesktop(context) || Responsive.isTablet(context)?screenSize.width/60 :screenSize.width/30),
      child: TextFormField(
        controller: controller,
        obscureText: (obscure == true)? true : false,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey[700],fontSize: Responsive.isDesktop(context) || Responsive.isTablet(context)?screenSize.width/80 : screenSize.width/40,
          ),
          filled: true,
          fillColor: loginBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey[700],
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),
      ),
    );
  }
}