import 'package:get/get.dart';

import '../controllers/parties_controller.dart';

class PartiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartiesController>(
      () => PartiesController(),
    );
  }
}
