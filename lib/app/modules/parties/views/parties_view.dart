import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/parties_controller.dart';

class PartiesView extends GetView<PartiesController> {
  const PartiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
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
                            onTap: () => Get.to(
                                () => const PartyTransactionDetail(),
                                arguments: element['id']),
                            leading: CircleAvatar(
                              backgroundColor: Colors.green[100],
                              child: const Icon(
                                Icons.person,
                                color: Colors.teal,
                              ),
                            ),
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
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.teal),
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
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.teal),
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
                            title: Text(
                              //element.toString() +
                              element['name'].toString().capitalizeFirst!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Phone Number :' + element['phone'].toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ))
                      .toList(),
                ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () async {
          await Get.toNamed(Routes.ADD_PARTY);
          controller.getParties();
        },
        tooltip: 'Add Payment party',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddPartyTransactionController extends GetxController {
  var isReceived = false.obs;
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
  final addPartyTransactionController =
      Get.put(AddPartyTransactionController());
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
                "received": addPartyTransactionController.isReceived.value
              });
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
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text("Add Party Transaction")),
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
                      onChanged: (String? v) async {
                        if (v == '') {
                          await Get.toNamed(Routes.ADD_PARTY);
                          
                          partiesController.getParties();
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
                if (!isCash)
                  Row(
                    children: [
                      Obx(() => Text(
                          !addPartyTransactionController.isReceived.value
                              ? 'Sending'
                              : "Receiving")),
                      Obx(() => Checkbox(
                          value: addPartyTransactionController.isReceived.value,
                          onChanged: (v) {
                            addPartyTransactionController.isReceived.value = v!;
                          }))
                    ],
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
                        style: ElevatedButton.styleFrom(primary: Colors.teal),
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

class PartyDetailController extends GetxController {
  var id = ''.obs;
  var data = {}.obs;
  var loading = false.obs;
  DashboardController homeController = Get.find();
  @override
  void onInit() {
    id.value = Get.arguments.toString();
    getPartyTransactions();
    super.onInit();
  }

  void getPartyTransactions() async {
    loading.value = true;
    var resp = await requestHandler.sendRequest(
        'GET', "${ApiEndpoints.party}/${id.value}",
        token: homeController.token.value,
        requestBody: {"chequeTransactions": true, "accountTransactions": true});
    if (resp is String) {
    } else {
      data.value = resp;
    }
    loading.value = false;
  }
}

class PartyTransactionDetail extends StatelessWidget {
  const PartyTransactionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PartyDetailController());
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Party Transactions")),
      body: SafeArea(
        child: Obx(() => controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Party Informaition",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: Colors.teal,
                              ),
                              title: Text(
                                controller.data.value['name']
                                    .toString()
                                    .capitalize!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.mail,
                                color: Colors.teal,
                              ),
                              title: Text(
                                controller.data.value['email']
                                    .toString()
                                    .capitalize!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on_outlined,
                                  color: Colors.teal),
                              title: Text(
                                controller.data.value['address']
                                    .toString()
                                    .capitalize!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                controller.data.value['phone']
                                    .toString()
                                    .capitalize!,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              leading: const Icon(
                                Icons.phone,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    controller.data['chequeTransactions'].length == 0
                        ? const Text("No transactions")
                        : Column(
                            children: [
                              ...controller.data['chequeTransactions']
                                  .map((e) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: DetailCard(
                                          element: e,
                                          controller: controller,
                                        ),
                                      ))
                            ],
                          ),
                    // Text(controller.data.value.toString())
                  ],
                ),
              )),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  const DetailCard({Key? key, this.element, this.controller}) : super(key: key);
  final element;
  final controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: element['drCr'] == true ? Colors.red[50] : Color(0xffe9fff3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(element.toString()),
            Row(
              children: [
                Text(
                  element['drCr'] == true ? 'Debit' : "Credit",
                  style: const TextStyle(
                      fontSize: 20,
                      // color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  DateFormat.yMMMEd()
                      .format(DateTime.parse(element['chequeDate'].toString())),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Text(
                  "Cheque no. : ",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  element['chequeNumber'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Rs. ${element['amount']}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const Text(
                  "Bounced : ",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                Text(
                  "${element['bounce']} times",
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "Remarks",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(
              element['detailJson']['decsription'].toString(),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            const SizedBox(
              height: 8,
            ),
            // Row(
            //   children: [
            //     ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.teal,
            //         ),
            //         onPressed: () {
            //           controller.bounceCheque(element);
            //         },
            //         child: const Text("Bounce")),
            //     const SizedBox(width: 10),
            //     ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           primary: Colors.teal,
            //         ),
            //         onPressed: () {
            //           var formKey = GlobalKey<FormState>();
            //           Get.dialog(AlertDialog(
            //             content: Form(
            //               key: formKey,
            //               child: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            // DropdownButtonFormField(
            //     value: controller.selectedAccountId.value,
            //     validator: validateIsEmpty,
            //     decoration:
            //         const InputDecoration(hintText: 'Choose'),
            //     items: [
            //       const DropdownMenuItem(
            //         value: '',
            //         child: Text('Choose'),
            //       ),
            //       ...controller.accounts
            //           .where((p0) =>
            //               p0['externallyManaged'] == true)
            //           .map(
            //             (element) => DropdownMenuItem(
            //               value: element['id'].toString(),
            //               child: Text(element['name']),
            //             ),
            //           ),
            //     ],
            //     onChanged: (String? v) {
            //       if (v != '') {
            //         controller.selectedAccountId.value = v!;
            //       }
            //     }),
            //                   MaterialButton(
            //                     onPressed: () {
            //                       if (formKey.currentState!.validate()) {
            //                         controller.clearCheque(element);
            //                       }
            //                     },
            //                     child: const Text('Subimit'),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ));
            //         },
            //         child: const Text("Clear"))
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
