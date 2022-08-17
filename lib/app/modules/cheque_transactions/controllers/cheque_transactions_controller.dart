import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';

class ChequeTransactionsController extends GetxController {
  final DashboardController dashboardController = Get.find();
  final count = 0.obs;
  var cheques = [].obs;
  var loading = false.obs;
  var accounts = [].obs;
  var allAccounts = [].obs;
  var selectedAccountId = ''.obs;
  var isPending = true.obs;
  var received = false.obs;
  var bounced = false.obs;
  getAccount() async {
    var res = await requestHandler.sendRequest('GET', ApiEndpoints.account,
        token: dashboardController.token.value);

    accounts.addAll(res);
    allAccounts.addAll(res);
  }

  @override
  void onInit() {
    getChequeTransactions();
    getAccount();
    super.onInit();
  }

  getChequeTransactions() async {
    var body = {
      "pending": isPending.value,
      "bounced": bounced.value,
      "received": received.value,
      // "partyId": 1
    };
    cheques.clear();
    var resp = await requestHandler.sendRequest(
        'GET', "${ApiEndpoints.party}/cheque/transactions",
        token: dashboardController.token.value, requestBody: body);
    // print(resp);
    if (resp is String) {
      // print(resp);
      getSnackbar(message: resp.toString());
    } else {
      cheques.addAll(resp);
    }
  }

  bounceCheque(element) async {
    // Get.dialog(Ale`rtDialog())
    var resp = await requestHandler.sendRequest(
        'POST', "${ApiEndpoints.party}/cheque/bounce",
        token: dashboardController.token.value,
        requestBody: {
          "bankId": element["bankId"],
          "chequeNumber": int.parse(element["chequeNumber"]),
          "description": element['detailJson']['decsription'],
          "bounceDate": DateTime.now().toIso8601String()
        });
    // print(resp);
    if (resp is String) {
      getSnackbar(message: resp);
    } else {
      getChequeTransactions();
    }
  }

  clearCheque(element) async {
    // print(int.parse(element["chequeNumber"]));
    var resp = await requestHandler.sendRequest(
        'POST', "${ApiEndpoints.party}/cheque/clear",
        token: dashboardController.token.value,
        requestBody: {
          "bankId": element["bankId"],
          "chequeNumber": int.parse(element["chequeNumber"]),
          "description": element['detailJson']['decsription'],
          "postTo": int.parse(selectedAccountId.value)
        });
    // print(resp);
    if (resp is String) {
      getSnackbar(message: resp);
    } else {
      Get.back();
      if (resp['status'] == 'error') {
        getSnackbar(message: resp['message'].toString());
      } else {
        getChequeTransactions();
      }

      // cheques.addAll(resp);
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
