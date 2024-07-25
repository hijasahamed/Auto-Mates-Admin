import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SidePanelSwitches extends StatelessWidget {
  const SidePanelSwitches({super.key,required this.screenSize,required this.textTitle});
  final Size screenSize;
  final String textTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: screenSize.height/50,bottom: screenSize.height/50,),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            
          },
          child: Ink(
            height: screenSize.height / 15,
            width: screenSize.width / 7,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(screenSize.width/200),
            ),
            child: Center(
              child: TextWidget(
                text: textTitle,
                color: const Color.fromARGB(255, 201, 201, 201),
                size: screenSize.width / 85,
                weight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}