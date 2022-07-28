import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/requestHelper.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/parties_controller.dart';

class PartiesView extends GetView<PartiesController> {
  const PartiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PartiesView'),
        centerTitle: true,
      ),
      body: Obx((() => controller.partiesloading.value
          ? const Text("Loading")
          : controller.parties.isEmpty
              ? const Text('Empty')
              : Column(
                  children: controller.parties
                      .map((element) => ListTile(
                            leading: const Icon(Icons.person),
                            trailing: InkWell(
                                onTap: () {
                                  if (kDebugMode) {
                                    print(element['phone']);
                                  }

                                  Get.dialog(AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                                Get.to(() =>
                                                    AddPartyTransactions());
                                              },
                                              child: const Text('Cash')),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                                Get.to(
                                                    () => AddPartyTransactions(
                                                          isCash: false,
                                                        ));
                                              },
                                              child: const Text('Cheque')),
                                        ),
                                      ],
                                    ),
                                  ));
                                },
                                child: const Text('Create \nTransactions')),
                            title: Text(element.toString() +
                                element['name'].toString()),
                            subtitle: Text(element['address'].toString()),
                          ))
                      .toList(),
                ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(Routes.ADD_PARTY);
          controller.getParties();
        },
        tooltip: 'Add Payment party',
        child: const Text('Add'),
      ),
    );
  }
}

class AddPartyTransactions extends StatelessWidget {
  AddPartyTransactions({Key? key, this.isCash = true}) : super(key: key);
  final bool isCash;
// addTransaction(){
//  var body= {
// 	"partyId": 1,
// 	"postTo": 1,
// 	"amount": 1500,
// 	"description": "Bribe for Mr Ward Mayor"
// };
// }
  final PartiesController partiesController = Get.find();
  final DashboardController dashboardController = Get.find();
  final partyId = TextEditingController();
  final postto = TextEditingController();
  final amount = TextEditingController();
  final desc = TextEditingController();
  final bankId = TextEditingController();
  final chequeDate = TextEditingController();
  final requestedDate = TextEditingController();
  final chequeNumber = TextEditingController();
  final received = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  void submit() async {
    var res = await requestHandler.sendRequest(
        'POST',
        isCash
            ? '${ApiEndpoints.party}/receive/cash'
            : '${ApiEndpoints.party}/cheque/transaction',
        token: dashboardController.token.value,
        requestBody: isCash
            ? {
                "partyId": int.parse(partyId.text),
                "postTo": int.parse(postto.text),
                "amount": double.parse(amount.text),
                "description": desc.text
              }
            : {
                "partyId": int.parse(partyId.text),
                "amount": double.parse(amount.text),
                "chequeNumber": int.parse(chequeNumber.text),
                "bankId": int.parse(bankId.text),
                "chequeDate": chequeDate.text,
                "requestedDate": requestedDate.text,
                "description": desc.text,
                "received": false
              });
    print(res);
    if (res['status'] == 'error') {
      getSnackbar(message: res['message'], bgColor: Colors.red);
    } else {
      Get.back();
      getSnackbar(message: "Success", bgColor: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add Party Transaction")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formkey,
              child: Column(children: [
                Obx(
                  () => DropdownButtonFormField(
                      validator: validateIsEmpty,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Select Payment Party',
                      ),
                      items: [
                        ...partiesController.parties
                            .map((element) => //null)
                                // ...transitionController.accountsController.accounts
                                //     .map((element) =>
                                DropdownMenuItem(
                                    value: element['id'].toString(),
                                    child: Text(element['name'].toString())))
                            .toList(),
                        const DropdownMenuItem(
                            value: '', child: Text('Create Party'))
                      ],
                      onChanged: (String? v) {
                        if (v == '') {
                          Get.toNamed(Routes.ADD_PARTY);
                        } else {
                          partyId.text = v.toString();
                        }
                      }),
                ),
                if (isCash)
                  DropdownButtonFormField(
                      validator: validateIsEmpty,
                      decoration: const InputDecoration(
                        hintText: 'To',
                      ),
                      items: [
                        const DropdownMenuItem(
                            value: '', child: Text('Create Account')),
                        ...partiesController.accounts
                            .where((p0) => p0['externallyManaged'] == isCash
                                ? false
                                : true)
                            .map((element) => DropdownMenuItem(
                                value: element['id'].toString(),
                                child: Text(element['name'].toString())))
                            .toList()
                      ],
                      onChanged: (String? v) async {
                        if (v == '') {
                          await Get.toNamed(Routes.ADD_PARTY);
                          partiesController.getParties();
                        } else {
                          postto.text = v.toString();
                        }
                      }),

                // CustomTextField(
                //     validator: validateIsEmpty,
                //     label: 'From',
                //     controller: from),
                // CustomTextField(label: 'to', isnum: true, controller: to),
                if (!isCash)
                  CustomTextField(
                      validator: (v) => validateMinLength(string: v, length: 3),
                      isnum: true,
                      label: 'Cheque No',
                      controller: chequeNumber),
                if (!isCash)
                  DropdownButtonFormField(
                      validator: validateIsEmpty,
                      decoration: const InputDecoration(
                        hintText: 'Bank',
                      ),
                      items: [
                        const DropdownMenuItem(
                            value: '', child: Text('Add Bank')),
                        ...partiesController.banks
                            .map((element) => DropdownMenuItem(
                                value: element['id'].toString(),
                                child: Text(element['name'].toString())))
                            .toList()
                      ],
                      onChanged: (String? v) async {
                        if (v == '') {
                          await Get.toNamed(Routes.ADD_BANK);
                          partiesController.getBanks();
                        } else {
                          bankId.text = v.toString();
                        }
                      }),
                CustomTextField(
                    validator: (v) => validateMinLength(string: v, length: 3),
                    isnum: true,
                    label: 'Amount',
                    controller: amount),
                if (!isCash)
                  InkWell(
                    onTap: () async {
                      var datePicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1));
                      if (datePicked != null) {
                        chequeDate.text = datePicked.toIso8601String();
                      }
                    },
                    child: CustomTextField(
                        enabled: false,
                        validator: (v) =>
                            validateMinLength(string: v, length: 3),
                        // isnum: true,
                        label: 'Cheque Date',
                        controller: chequeDate),
                  ),

                if (!isCash)
                  InkWell(
                    onTap: () async {
                      var datePicked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1));
                      if (datePicked != null) {
                        requestedDate.text = datePicked.toIso8601String();
                      }
                    },
                    child: CustomTextField(
                        enabled: false,
                        validator: (v) =>
                            validateMinLength(string: v, length: 3),
                        // isnum: true,
                        label: 'Requested Date',
                        controller: requestedDate),
                  ),
                CustomTextField(
                    validator: (v) => validateMinLength(string: v, length: 3),
                    // isnum: true,
                    label: 'Description',
                    desc: true,
                    controller: desc),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            submit();
                          }
                        },
                        child: const Text('Submit')))
              ]),
            ),
          ),
        ));
  }
}
