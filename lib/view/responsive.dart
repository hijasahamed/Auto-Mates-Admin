import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key,required this.mobile,required this.desktop,this.tablet});
  final Widget mobile;
  final Widget desktop;
  final Widget? tablet;

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if(size.width>=1100){
      return desktop;
    }
    else if(size.width >= 850 && tablet != null){
      return tablet!;
    }
    else{
      return mobile;
    }
  }
}