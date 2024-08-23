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

  var userSearchQuery = ''.obs; 

  void updateSearchQuery(String query) {
    userSearchQuery.value = query.toLowerCase();
  }

  List<Map<String, dynamic>> getFilteredSellers(List<Map<String, dynamic>> allUsers) {
    if (userSearchQuery.isEmpty) {
      return allUsers;
    } else {
      return allUsers.where((user) {
        return user['userName']
            .toString()
            .toLowerCase()
            .contains(userSearchQuery.value);
      }).toList();
    }
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


  var searchQuery = ''.obs; 

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
  }

  List<Map<String, dynamic>> getFilteredSellers(List<Map<String, dynamic>> allSellers) {
    if (searchQuery.isEmpty) {
      return allSellers;
    } else {
      return allSellers.where((seller) {
        return seller['companyName']
            .toString()
            .toLowerCase()
            .contains(searchQuery.value);
      }).toList();
    }
  }

}