import 'package:get/get.dart';
import 'package:paymentmanagement/app/data/models/transaction.dart';

class RegisterOutgoingTransactionsController extends GetxController { 
  var promiseType = ''.obs;
  var promisetype = PromiseType.CASH.obs;
  var selectedImages = [].obs;
  final count = 0.obs;
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
