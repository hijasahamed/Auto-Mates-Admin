import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeScreenController extends GetxController{

  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
  
}

class AdminUserController extends GetxController {
  var isBlocked = false.obs;
  String? blockedUserId;

  Future<String?> checkIfUserBlocked(String userId) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('blocked_users')
        .where('userId', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      isBlocked.value = true;
      blockedUserId = querySnapshot.docs.first.get('userId');
    } else {
      isBlocked.value = false;
      blockedUserId = null;
    }
    
    return blockedUserId;
  }

  bool isUserBlocked(String userId) {
    return blockedUserId == userId;
  }
}