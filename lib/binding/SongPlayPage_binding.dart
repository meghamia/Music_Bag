import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../controllers/songPlayerController.dart';

class SongPlayPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }

}