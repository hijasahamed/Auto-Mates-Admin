import 'package:auto_mates_admin/view/admin_home_screen/side_panel/side_panel_switches/side_panel_switches.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({super.key,required this.screenSize});
  final Size screenSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenSize.height,
      width: screenSize.width/6,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 20, 20, 20),
        borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))
      ),
      child: Column(
        children: [
          TextWidget(text: 'Auto Mates', color: Colors.white, size: screenSize.width/40, weight: FontWeight.bold),
          SidePanelSwitches(screenSize: screenSize, textTitle: 'Overview'),
          SidePanelSwitches(screenSize: screenSize, textTitle: 'Car Sellers'),
        ],
      ),
    );
  }
}