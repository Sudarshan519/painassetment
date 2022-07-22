import 'package:get/get.dart';

import '../controllers/register_incoming_transactions_controller.dart';

class RegisterIncomingTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterIncomingTransactionsController>(
      () => RegisterIncomingTransactionsController(),
    );
  }
}
