import 'package:get/get.dart';

import '../controllers/add_transactions_controller.dart';

class AddTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTransactionsController>(
      () => AddTransactionsController(),
    );
  }
}
