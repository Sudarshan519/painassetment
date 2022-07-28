import 'package:get/get.dart';

import '../controllers/cheque_transactions_controller.dart';

class ChequeTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChequeTransactionsController>(
      () => ChequeTransactionsController(),
    );
  }
}
