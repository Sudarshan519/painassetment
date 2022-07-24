import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';
import 'package:paymentmanagement/app/utils/storageService.dart';

class TransitionController extends GetxController {
  //TODO: Implement TransitionController
  final DashboardController dashboardController = Get.find();
  var loading = false.obs;
  var transactions = [].obs;
  getTransactions(id) async {
    loading.value = true;
    var res = await requestHandler.sendRequest(
        'GET', ApiEndpoints.gettransactions + id.toString(),
        token: dashboardController.token.value);
    loading.toggle();
    transactions.addAll(res);
  }

  @override
  void onInit() {
    super.onInit();
    var id = Get.arguments;
    getTransactions(id);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
