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
  final dynamic rowsPerPage = 15;

  void nextPage() {
    currentPage.value++;
    update();
  }

  void previousPage() {
    currentPage.value--;
    update();
  }

}

class AdminSellerController extends GetxController{

Stream<bool> sellerBlockStatusStream({sellerId}) {
    return FirebaseFirestore.instance
        .collection('blocked_sellers')
        .where('sellerId', isEqualTo: sellerId)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  var currentPage = 0.obs;
  final dynamic rowsPerPage = 15;

  void nextPage() {
    currentPage.value++;
    update();
  }

  void previousPage() {
    currentPage.value--;
    update();
  }
}