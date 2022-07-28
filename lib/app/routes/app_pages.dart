import 'package:get/get.dart';

import '../modules/accounts/bindings/accounts_binding.dart';
import '../modules/accounts/views/accounts_view.dart';
import '../modules/add_account/bindings/add_account_binding.dart';
import '../modules/add_account/views/add_account_view.dart';
import '../modules/add_bank/bindings/add_bank_binding.dart';
import '../modules/add_bank/views/add_bank_view.dart';
import '../modules/add_party/bindings/add_party_binding.dart';
import '../modules/add_party/views/add_party_view.dart';
import '../modules/add_role/bindings/add_role_binding.dart';
import '../modules/add_role/views/add_role_view.dart';
import '../modules/add_transaction/bindings/add_transaction_binding.dart';
import '../modules/add_transaction/views/add_transaction_view.dart';
import '../modules/add_transactions/bindings/add_transactions_binding.dart';
import '../modules/add_transactions/views/add_transactions_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/banks/bindings/banks_binding.dart';
import '../modules/banks/views/banks_view.dart';
import '../modules/cheque_transactions/bindings/cheque_transactions_binding.dart';
import '../modules/cheque_transactions/views/cheque_transactions_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/parties/bindings/parties_binding.dart';
import '../modules/parties/views/parties_view.dart';
import '../modules/register_incoming_transactions/bindings/register_incoming_transactions_binding.dart';
import '../modules/register_incoming_transactions/views/register_incoming_transactions_view.dart';
import '../modules/register_outgoing_transactions/bindings/register_outgoing_transactions_binding.dart';
import '../modules/register_outgoing_transactions/views/register_outgoing_transactions_view.dart';
import '../modules/roles/bindings/roles_binding.dart';
import '../modules/roles/views/roles_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/transactions/bindings/transition_binding.dart';
import '../modules/transactions/views/transition_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

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
    GetPage(
      name: _Paths.ROLES,
      page: () => RolesView(),
      binding: RolesBinding(),
    ),
    GetPage(
      name: _Paths.BANKS,
      page: () => BanksView(),
      binding: BanksBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNTS,
      page: () => AccountsView(),
      binding: AccountsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSITION,
      page: () => TransitionView(),
      binding: TransitionBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ACCOUNT,
      page: () => AddAccountView(),
      binding: AddAccountBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BANK,
      page: () => AddBankView(),
      binding: AddBankBinding(),
    ),
    GetPage(
      name: _Paths.PARTIES,
      page: () => PartiesView(),
      binding: PartiesBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TRANSACTION,
      page: () => AddTransactionView(),
      binding: AddTransactionBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PARTY,
      page: () => AddPartyView(),
      binding: AddPartyBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TRANSACTIONS,
      page: () => AddTransactionsView(),
      binding: AddTransactionsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ROLE,
      page: () => AddRoleView(),
      binding: AddRoleBinding(),
    ),
    GetPage(
      name: _Paths.CHEQUE_TRANSACTIONS,
      page: () => ChequeTransactionsView(),
      binding: ChequeTransactionsBinding(),
    ),
  ];
}
