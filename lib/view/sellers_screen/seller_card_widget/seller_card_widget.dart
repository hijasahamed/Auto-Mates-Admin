import 'package:auto_mates_admin/view/common_widgets/colors.dart';
import 'package:auto_mates_admin/view/common_widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SellerCardWidget extends StatelessWidget {
  final String companyName;
  final String location;
  final String mobile;
  final String sellerProfile;
  final Size screenSize;

  const SellerCardWidget({
    super.key, 
    required this.companyName,
    required this.location,
    required this.mobile,
    required this.sellerProfile,
    required this.screenSize
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shadowColor: colorBlueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenSize.width/150),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width/140),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             ClipRRect(
              borderRadius: BorderRadius.circular(screenSize.width / 150),
              child: sellerProfile.isNotEmpty
                  ? Image.network(
                      sellerProfile,
                      width: screenSize.width / 6,
                      height: screenSize.width / 6,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: screenSize.width / 6,
                          height: screenSize.width / 6,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Container(
                          width: screenSize.width / 6,
                          height: screenSize.width / 6,
                          color: Colors.grey.shade200,
                          child: Icon(Icons.error, size: screenSize.width / 10),
                        );
                      },
                    )
                  : Container(
                      width: screenSize.width / 6,
                      height: screenSize.width / 6,
                      color: Colors.grey,
                      child: Icon(
                        Icons.image,
                        size: screenSize.width / 10,
                      ),
                    ),
            ),
            SizedBox(width: screenSize.width / 50),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: companyName, color: colorBlueGrey, size: screenSize.width/50, weight: FontWeight.w500,maxline: true,),
                      IconButton(
                        onPressed: () {
                          
                        }, 
                        icon: const Icon(Icons.more_vert,color: sideBarColor,)
                      )
                    ],
                  ),
                  SizedBox(height: screenSize.width / 140),
                  TextWidget(text: 'Location: $location', color: colorBlueGrey, size: screenSize.width/120, weight: FontWeight.w500),
                  TextWidget(text: 'Mobile: $mobile', color: colorBlueGrey, size: screenSize.width/120, weight: FontWeight.w500),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}