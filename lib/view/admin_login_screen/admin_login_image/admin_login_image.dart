import 'package:flutter/material.dart';

class AdminLoginImage extends StatelessWidget {
  const AdminLoginImage({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height/2.3,
      width: screenSize.width/3.5,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/login background.png'),fit: BoxFit.cover)
      ),
    );
  }
}