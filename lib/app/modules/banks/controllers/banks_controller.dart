 
import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';

class BanksController extends GetxController {
  final DashboardController homeController = Get.find();
  final count = 0.obs;
  var bankloading = false.obs;
  var banks = [].obs;
  getBanks() async {
    banks.clear();
    bankloading.value = true;
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.bank,
        token: homeController.token.value);
   
    bankloading.value = false;
    banks.addAll(res);
  }

  @override
  void onInit() {
    getBanks();
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
