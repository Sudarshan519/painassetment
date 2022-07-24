import 'package:get/get.dart';

import '../controllers/banks_controller.dart';

class BanksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BanksController>(
      () => BanksController(),
    );
  }
}
