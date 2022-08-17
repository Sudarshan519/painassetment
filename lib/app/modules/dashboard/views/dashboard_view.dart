import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:paymentmanagement/app/data/models/transaction.dart';
import 'package:paymentmanagement/app/modules/dashboard/views/chart.dart';
import 'package:paymentmanagement/app/routes/app_pages.dart';
import 'package:paymentmanagement/app/widgets/response_widgets.dart';
import 'package:photo_view/photo_view.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(controller.token.value);
    var height = Get.size.height;
    var width = Get.size.width;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        drawer: const DrawerWidget(),
        body: ResponsiveWidget(
          tabletScreen: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(scaffoldKey: scaffoldKey),
            ],
          ),
          desktopScreen: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(scaffoldKey: scaffoldKey),
            ],
          ),
          mobileScreen: controller.token.value == ''
              ? const Text('Unauthorized')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderWidget(scaffoldKey: scaffoldKey),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  topLeft: Radius.circular(50))),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  height: 60,
                                ),
                                // Center(
                                //   child: InkWell(
                                //     onTap: () {
                                //       Get.to(() => const AllTransactions(),
                                //           arguments: 'HISTORY');
                                //     },
                                //     child: Container(
                                //       width: width * .8,
                                //       height: height * .20,
                                //       decoration: BoxDecoration(
                                //         color: Colors.grey[200],
                                //         borderRadius: BorderRadius.circular(10),
                                //       ),
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 25),
                                //       child: Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.spaceEvenly,
                                //           children: [
                                //             const CircleAvatar(
                                //                 backgroundColor: Colors.teal,
                                //                 child: Icon(
                                //                   Icons.payments_outlined,
                                //                 )),
                                //             Text(
                                //               "123 TOTAL Transactions"
                                //                   .toUpperCase(),
                                //               style: const TextStyle(
                                //                   fontWeight: FontWeight.bold),
                                //             ),
                                //             Text(
                                //               'View History',
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .bodySmall,
                                //             )
                                //           ]),
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 60,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Text(
                                //     "Our Services",
                                //     style:
                                //         Theme.of(context).textTheme.titleLarge,
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 16,
                                // ),
                                AllTransactionsWidgets(),
                                // const ChartWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ));
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const UserAccountsDrawerHeader(
            accountName: Text(''), accountEmail: Text('')),
        // ListTile(
        //   leading: const Icon(Icons.person),
        //   onTap: () {
        //     Get.toNamed(Routes.ROLES);
        //   },
        //   title: const Text('Roles'),
        // ),
        ListTile(
          leading: const Icon(
            Icons.account_balance,
            color: Colors.teal,
          ),
          onTap: () {
            Get.toNamed(Routes.ACCOUNTS);
          },
          title: const Text('Accounts'),
        ),
        ListTile(
          leading: const Icon(
            Icons.monetization_on,
            color: Colors.teal,
          ),
          onTap: () {
            Get.toNamed(Routes.BANKS);
          },
          title: const Text('Banks'),
        ),
        ListTile(
          leading: const Icon(
            Icons.people,
            color: Colors.teal,
          ),
          onTap: () {
            Get.toNamed(Routes.PARTIES);
          },
          title: const Text('Parties'),
        ),
        ListTile(
          leading: const Icon(
            Icons.people,
            color: Colors.teal,
          ),
          onTap: () {
            Get.toNamed(Routes.CHEQUE_TRANSACTIONS);
          },
          title: const Text('Cheque Transactions'),
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.teal,
          ),
          onTap: () {
            Get.toNamed(Routes.AUTH);
          },
          title: const Text('Logout'),
        ),
      ],
    ));
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Welcome',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
        const Spacer(),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Colors.teal),
        ),
      ]),
    );
  }
}

class AllTransactionsWidgets extends StatelessWidget {
  const AllTransactionsWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [

        TransitionWidget(
            label: 'Accounts',
            icon: Icons.account_balance,
            onTap: () => Get.toNamed(Routes.ACCOUNTS)),
        TransitionWidget(
            label: 'Banks',
            icon: Icons.attach_money_outlined,
            onTap: () => Get.toNamed(Routes.BANKS)),
        TransitionWidget(
            label: 'Parties',
            icon: Icons.people,
            onTap: () => Get.toNamed(Routes.PARTIES)),
        TransitionWidget(
            label: 'Pending ',
            icon: Icons.people,
            onTap: () => Get.toNamed(Routes.CHEQUE_TRANSACTIONS)),
        // TransitionWidget(
        //   label: 'All Trans',
        //   onTap: () =>
        //       Get.to(const AllTransactions(), arguments: "All Transactions"),
        //   icon: Icons.track_changes,
        // ),
        // TransitionWidget(
        //   onTap: () => Get.to(const AllTransactions(),
        //       arguments: "Pending Transactions"),
        //   label: 'Pending Trans',
        //   icon: Icons.pending,
        // ),
        // TransitionWidget(
        //   onTap: () => Get.to(const AllTransactions(),
        //       arguments: "Outgoing Transactions"),
        //   label: 'Outgoing Trans',
        //   icon: Icons.outbond,
        // ),
        // TransitionWidget(
        //   onTap: () => Get.to(const AllTransactions(),
        //       arguments: "Incoming Transactions"),
        //   label: 'Incoming Trans',
        //   icon: Icons.move_to_inbox,
        // ),
        // TransitionWidget(
        //   onTap: () => Get.toNamed(Routes.REGISTER_INCOMING_TRANSACTIONS),
        //   label: 'Register Incoming Trans',
        //   icon: Icons.app_registration,
        // ),
        // TransitionWidget(
        //   onTap: () => Get.toNamed(Routes.REGISTER_OUTGOING_TRANSACTIONS),
        //   label: 'Register Outgoing Trans',
        //   icon: Icons.app_registration,
        // ),
        // TransitionWidget(
        //   label: 'All Incoming Trans',
        //   icon: Icons.money,
        // ),
      ],
    );
  }
}

class AllTransactions extends StatefulWidget {
  const AllTransactions({
    Key? key,
  }) : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  Widget build(BuildContext context) {
    
    // debugPrint(jsonEncode(staticData[0]));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(Get.arguments.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChartWidget(),
            ),
            ...userData.map((e) => Container(
                // width: double.infinity,
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    // color: Colors.green[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TransactionCard(transaction: Transaction.fromJson(e)),
                  ],
                )))
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);
  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shadowColor: Colors.pinkAccent,
        color: Colors.green[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [ 
              Text(
                "Payment ${transaction.promise}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 6,
              ),
              Text("Payment Type ${transaction.promiseType}"),
              SizedBox(
                height: 6,
              ),
              if (transaction.promiseType == "CHEQUE")
                Text("BANK NAME : ${transaction.bankName}"),
              Text("Transaction Amount: Rs.${transaction.amount}"),
              SizedBox(
                height: 6,
              ),
              Text("Transaction Date:${transaction.promisedDate}"),
              SizedBox(
                height: 6,
              ),
              Text("Transaction Party:${transaction.user}"),
              Text(
                  "Transaction Type:${transaction.incoming! ? "Incoming" : "Outgoing"}"),
              Text(
                  "Transaction Status:${transaction.isprocessing! ? "Pending" : "Completed"}"),
              const Text("Photos"),
              Wrap(
                children: transaction.uploadPath!
                    .map((e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => Scaffold(
                                    body: PhotoView(
                                      imageProvider: NetworkImage(e),
                                    ),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(e,
                                  height: 80,
                                  // width: double.infinity,
                                  fit: BoxFit.fill
                                  //  height: 80,
                                  ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.teal),
                  onPressed: () {},
                  child: const Text("Clear Payment"))
            ],
          ),
        ),
      ),
    );
  }
}

class TransitionWidget extends StatelessWidget {
  const TransitionWidget(
      {Key? key, required this.label, required this.icon, required this.onTap})
      : super(key: key);
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            height: 80,
            width: 80,
            child: Icon(icon, color: Colors.teal),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 100,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.teal, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
