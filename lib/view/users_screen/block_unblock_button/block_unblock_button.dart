import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/function_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockUnblockButton extends StatelessWidget {
  BlockUnblockButton({super.key,required this.user,required this.screenSize});
  final Map<String, dynamic> user;
  final Size screenSize;
  final AdminUserController adminUserController = Get.put(AdminUserController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: adminUserController.userBlockStatusStream(user['id']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
        }        
        bool isUserBlocked = snapshot.data ?? false;
        return ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              isUserBlocked ? Colors.green : Colors.red,
            ),
          ),
          onPressed: () {
            blockAndUnblockUsersAlertDialog(user: user, isUserBlocked: isUserBlocked);
          },
          child: Text(
            isUserBlocked ? 'Unblock' : 'Block',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenSize.width / 150,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}