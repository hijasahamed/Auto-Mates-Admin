import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/view/overview_screen/overview_responsive_screens/overview_responsive_screens.dart';
import 'package:auto_mates_admin/model/responsive.dart';
import 'package:flutter/material.dart';


class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key, required this.screenSize, required this.adminHomeScreenController});
  final Size screenSize;
  final AdminHomeScreenController adminHomeScreenController;
  @override
  Widget build(BuildContext context) {
    if(Responsive.isDesktop(context) || Responsive.isTablet(context)){
      return OverviewDesktopAndTablet(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController);
    }
    else{
      return OverviewMobile(screenSize: screenSize, adminHomeScreenController: adminHomeScreenController);
    }
  }
}