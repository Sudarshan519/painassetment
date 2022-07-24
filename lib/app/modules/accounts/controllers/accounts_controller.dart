import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';

class AccountsController extends GetxController {
  final DashboardController homeController = Get.find();

  
  final count = 0.obs;
  var accounts = [].obs;
  var accountloading = false.obs;
  getAccount() async {
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.account,
        token: homeController.token.value);
    accountloading.value = false;
    accounts.addAll(res);
  }

  

  sendMoney() async {
    var body = {'from': '1', 'to': '2', "amount": 50};
    var res = await requestHandler.sendRequest(
        'POST', ApiEndpoints.account + '/transaction',
        token: homeController.token.value);
  }

  @override
  void onInit() {
    getAccount();
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
