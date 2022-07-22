import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paymentmanagement/app/data/models/transaction.dart';
import 'package:paymentmanagement/app/modules/auth/views/pages/login.dart';
import 'package:paymentmanagement/app/utils/validator.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/register_outgoing_transactions_controller.dart';

class RegisterOutgoingTransactionsView
    extends GetView<RegisterOutgoingTransactionsController> {
  const RegisterOutgoingTransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final promise = TextEditingController();
    final bankName = TextEditingController();
    final promiseType = TextEditingController();
    final chequeNumber = TextEditingController();
    final bounceNo = TextEditingController();
    final amount = TextEditingController();
    final promiseDate = TextEditingController();
    final user = TextEditingController();
    final remarks = TextEditingController();
    final incoming = TextEditingController();
    final isProcessing = TextEditingController();
    final party = TextEditingController();
    final uploadPath = [];
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Outgoing Transactions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Form(
          key: formKey,
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  validator: validateIsEmpty,
                  label: 'Payment For',
                  controller: promise),
              CustomTextField(
                  validator: validateIsEmpty,
                  label: 'Payment Client',
                  controller: party),
              Obx(
                () => DropdownButtonFormField(
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: 'Select your payment type'),
                    value: controller.promisetype.value,
                    items: const [
                      
                      DropdownMenuItem(
                        value: PromiseType.CASH,
                        child: Text("Cash"),
                      ),
                      DropdownMenuItem(
                        value: PromiseType.CHEQUE,
                        child: Text("Cheque"),
                      ),
                       DropdownMenuItem(
                        value: PromiseType.WALLET,
                        child: Text("Wallet"),
                      ),
                      DropdownMenuItem(
                        value: PromiseType.UNKNOWN,
                        child: Text("Unknown"),
                      ),
                    ],
                    onChanged: (PromiseType? v) {
                      controller.promiseType.value =
                          v.toString().split('.').last;
                    }),
              ),
              Obx(() => controller.promiseType.value == 'CHEQUE'
                  ? CustomTextField(
                      validator: validateIsEmpty,
                      label: 'Bank Name',
                      controller: bankName)
                  : Container()),
              Obx(() => controller.promiseType.value == 'CHEQUE'
                  ? CustomTextField(
                      label: 'Cheque No.', controller: chequeNumber)
                  : Container()),
              CustomTextField(
                  label: 'Amount',
                  validator: validateIsEmpty,
                  controller: amount),
              GestureDetector(
                onTap: () async {
                  var datePicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (datePicked != null) {
                    promiseDate.text = datePicked.toString().substring(0, 10);
                  }
                },
                child: CustomTextField(
                    enabled: false,
                    label: 'Select your promise date',
                    controller: promiseDate),
              ),
              
              TextFormField(
                validator: validateIsEmpty,
                maxLines: 4, 
                decoration: const InputDecoration(labelText: "Remarks"),

              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('Select Image to Continue '),
                  ElevatedButton(
                      onPressed: () async {
                     final ImagePicker picker = ImagePicker();
                        Get.dialog(AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    var tempImg = await picker.pickImage(
                                        source: ImageSource.camera);
                                    if (tempImg != null) {
                                      controller.selectedImages.add(tempImg);
                                    }
                                    Get.back();
                                  },
                                  child: const Text("Camera")),
                              ElevatedButton(
                                  onPressed: () async {
                                    final List<XFile>? images =
                                        await picker.pickMultiImage();
                                    for (var element in images!) {
                                      controller.selectedImages.add(element);
                                    }
                                    Get.back();
                                  },
                                  child: const Text("Gallery")),
                            ],
                          ),
                        ));
                      },
                      child: const Text("Browse"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => controller.selectedImages.isNotEmpty
                  ? Wrap(
                      children: controller.selectedImages
                          .map((element) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              width: Get.size.width * .25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                        () => Scaffold(
                                            backgroundColor: Colors.black,
                                            body: SafeArea(
                                                child: PhotoView(
                                              imageProvider:
                                                  FileImage(File(element.path)),
                                            ))),
                                      );
                                    },
                                    child: Image.file(
                                      File(element.path),
                                      fit: BoxFit.contain,

                                      height: 260,
                                      // width: 260,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 24),
                                    child: InkWell(
                                      onTap: () {
                                        controller.selectedImages
                                            .remove(element);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.grey.withOpacity(.8),
                                        radius: 16,
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )))
                          .toList(),
                    )
                  : SizedBox()),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: const Text('Submit')))
            ],
          ),
        ),
      ),
    );
  }
}
