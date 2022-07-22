import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/register_incoming_transactions/bindings/register_incoming_transactions_binding.dart';
import '../modules/register_incoming_transactions/views/register_incoming_transactions_view.dart';
import '../modules/register_outgoing_transactions/bindings/register_outgoing_transactions_binding.dart';
import '../modules/register_outgoing_transactions/views/register_outgoing_transactions_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_INCOMING_TRANSACTIONS,
      page: () => RegisterIncomingTransactionsView(),
      binding: RegisterIncomingTransactionsBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_OUTGOING_TRANSACTIONS,
      page: () => RegisterOutgoingTransactionsView(),
      binding: RegisterOutgoingTransactionsBinding(),
    ),
  ];
}
