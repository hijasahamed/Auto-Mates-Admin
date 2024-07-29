import 'package:auto_mates_admin/controller/admin_controllers.dart';
import 'package:auto_mates_admin/controller/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlockUnblockButton extends StatelessWidget {
  BlockUnblockButton({super.key,required this.user});
  final Map<String, dynamic> user;
  final AdminUserController adminusercontroller = Get.put(AdminUserController());

  @override
  Widget build(BuildContext context) {
    adminusercontroller.checkIfUserBlocked(user['id']);
    return Obx(() {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            adminusercontroller.isUserBlocked(user['id']) ? Colors.green : Colors.red,
          ),
        ),
        onPressed: () {
          blockAndUnblockUsers(user: user,adminusercontroller: adminusercontroller);
        },
        child: Text(
          adminusercontroller.isBlocked.value ? 'Unblock' : 'Block',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width / 150,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    });
  }
}