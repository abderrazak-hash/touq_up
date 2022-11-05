import 'package:cloud_toq_system/main.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  var currentPage = 0.obs;
  @override
  void onInit() {
    super.onInit();
    save();
  }

  void save() async {
    sharedPreferences!.setBool('onBoard', true);
  }
}
