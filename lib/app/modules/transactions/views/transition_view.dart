import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/const/api_endpoints.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';
import 'package:paymentmanagement/app/utils/getsnackbar.dart';
import 'package:paymentmanagement/app/utils/request_helper.dart';
import 'package:paymentmanagement/app/utils/validator.dart';

import '../controllers/transition_controller.dart';

class TransitionView extends GetView<TransitionController> {
  const TransitionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Transactions'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.loading.value
            ? const CircularProgressIndicator()
            : controller.transactions.isEmpty
                ? const Text("Empty")
                : SingleChildScrollView(
                    child: Column(
                        children: controller.transactions
                            .map((element) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18.0,
                                      ),
                                      child: Text("BANK NAME"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0,
                                      ),
                                      child: Text(
                                        element['name']
                                            .toString()
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                      ),
                                    ),
                                  
                                    ...element['transactions']
                                      .map((e) =>
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Card(
                                            color: Colors.green[100],
                                            shadowColor: Colors.pinkAccent,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0,
                                                      vertical: 12),
                                              child: ListTile(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Text(e.toString()),
                                                    // Text(
                                                    //   '${e['detailJson']['tags'].toString().replaceAll('[', '').replaceAll(']', '').capitalizeFirst}\nTransferred Amount:'
                                                    //   'Rs.${e['amount']}\nResulting Balance : Rs.${e['resultingAmount']}',
                                                    // ),
                                                    Text(
                                                      '${e['detailJson']['tags'].toString().replaceAll('[', '').replaceAll(']', '').capitalizeFirst}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'Transferred Amount : '
                                                      'Rs.${e['amount']}',
                                                    ),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                        'Resulting Balance : Rs.${e['resultingAmount']}'),
                                                    SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      'Remarks : ' +
                                                          e['detailJson'][
                                                                  'description']
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        // color:
                                                        //     Colors.grey[600],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ))
                            .toList()),
                  ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          heroTag: 'send',
          onPressed: () async {
            await Get.to(
              () => AddTransactions(),
            );
            // Get.toNamed(Routes.ADD_BANK);
          },
          child: const Icon(Icons.send),
        ),
        // FloatingActionButton(
        //   heroTag: 'receive',
        //   backgroundColor: Theme.of(context).primaryColor,
        //   onPressed: () async {
        //     await Get.to(
        //       () => AddTransactions(
        //         isSending: false,
        //       ),
        //     );
        //     // Get.toNamed(Routes.ADD_BANK);
        //   },
        //   child: const Icon(Icons.add),
        // ),
      ]),
    );
  }
}

class AddTransactions extends StatelessWidget {
  AddTransactions({Key? key, this.isSending = true}) : super(key: key);
  final bool isSending;
  final DashboardController dashboardController = Get.find();
  final TransitionController transitionController = Get.find();
  final from = TextEditingController();
  final to = TextEditingController();
  final amount = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  void submit() async {
    var res = await requestHandler.sendRequest(
        'POST', '${ApiEndpoints.account}/transaction',
        token: dashboardController.token.value,
        requestBody: {
          "from": int.parse(from.text),
          "to": int.parse(to.text),
          "amount": double.parse(amount.text)
        });
    if (res['status'] == 'error') {
      getSnackbar(message: res['message'], bgColor: Colors.red);
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("${isSending ? 'Send' : 'Add'} Payment")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formkey,
              child: Column(children: [
                DropdownButtonFormField(
                    validator: validateIsEmpty,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'From',
                    ),
                    items: [
                      ...transitionController.accountsController.accounts
                          .where((p0) => p0['externallyManaged'] == false)
                          .map((element) => DropdownMenuItem(
                              value: element['id'].toString(),
                              child: Text(element['name'].toString())))
                          .toList(),
                      const DropdownMenuItem(
                          value: '', child: Text('Create Account'))
                    ],
                    onChanged: (String? v) {
                      if (v == '') {
                        Get.toNamed(Routes.ADD_ACCOUNT);
                      } else {
                        from.text = v.toString();
                      }
                    }),
                DropdownButtonFormField(
                    validator: validateIsEmpty,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'To',
                    ),
                    items: transitionController.accountsController.accounts
                        .where((p0) => p0['externallyManaged'] == false)
                        .map((element) => DropdownMenuItem(
                            value: element['id'].toString(),
                            child: Text(element['name'].toString())))
                        .toList(),
                    onChanged: (String? v) {
                      to.text = v.toString();
                    }),

                // CustomTextField(
                //     validator: validateIsEmpty,
                //     label: 'From',
                //     controller: from),
                // CustomTextField(label: 'to', isnum: true, controller: to),
                CustomTextField(
                    validator: (v) => validateMinLength(string: v, length: 3),
                    isnum: true,
                    label: 'Amount',
                    controller: amount),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
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
