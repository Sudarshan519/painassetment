import 'package:get/get.dart';
import 'package:paymentmanagement/app/data/models/transaction.dart';

class RegisterIncomingTransactionsController extends GetxController {
 
  final count = 0.obs;
  var promisetype = PromiseType.CASH.obs;
  var selectedImages = [].obs;
  var promiseType =''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
