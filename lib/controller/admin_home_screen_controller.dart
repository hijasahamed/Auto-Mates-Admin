import 'package:get/get.dart';

class AdminHomeScreenController extends GetxController{
  var selectedIndex = 0.obs;
  void changePage(int index) {
    selectedIndex.value = index;
  }
}