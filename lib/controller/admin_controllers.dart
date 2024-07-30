import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminHomeScreenController extends GetxController {
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }
}

class AdminUserController extends GetxController {

  Stream<bool> userBlockStatusStream(String userId) {
    return FirebaseFirestore.instance
        .collection('blocked_users')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  var currentPage = 0.obs;
  final dynamic rowsPerPage = 5;

  void nextPage() {
    currentPage.value++;
  }

  void previousPage() {
    currentPage.value--;
  }

}