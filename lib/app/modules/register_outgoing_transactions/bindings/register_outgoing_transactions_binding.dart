import 'package:get/get.dart';

import '../controllers/register_outgoing_transactions_controller.dart';

class RegisterOutgoingTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterOutgoingTransactionsController>(
      () => RegisterOutgoingTransactionsController(),
    );
  }
}
