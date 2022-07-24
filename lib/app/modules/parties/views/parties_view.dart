import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';

import '../controllers/parties_controller.dart';

class PartiesView extends GetView<PartiesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PartiesView'),
        centerTitle: true,
      ),
      body: Obx((() => controller.partiesloading.value
          ? Text("Loading")
          : controller.parties.isEmpty
              ? Text('Empty')
              : Column(
                  children: controller.parties
                      .map((element) => ListTile(
                            leading: Icon(Icons.person),
                            trailing: InkWell(
                                onTap: () {
                                  print(element['phone']);
                                  // Text(element['phone']);
                                },
                                child: Icon(Icons.phone)),
                            title: Text(element['name'].toString()),
                            subtitle: Text(element['address'].toString()),
                          ))
                      .toList(),
                ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_PARTY);
        },
        tooltip: 'Add Payment party',
        child: Text('Add'),
      ),
    );
  }
}
