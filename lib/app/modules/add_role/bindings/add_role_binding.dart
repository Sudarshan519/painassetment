import 'package:get/get.dart';

import '../controllers/add_role_controller.dart';

class AddRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRoleController>(
      () => AddRoleController(),
    );
  }
}
