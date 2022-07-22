class ApiEndpoints {
  static const baseUrl = "https://192.168.1.70:3000";
  static const login = baseUrl + "/auth/login";
  static const signup = baseUrl + "/user";
  static const getroles = baseUrl + "/auth/roles";
  static const addrole = baseUrl + "/auth/role";

  ///accounts endpoints
  // transactions
  static const gettransactions = baseUrl + '/account/transactions/';
  static const posttransaction = baseUrl + 'account/transaction/';

  static const account = baseUrl + "/accounts";

  ///bank get/post
  static const bank = baseUrl + "/bank";
  static const bankAccount = bank + '/account';

  //party get/post
  static const party = baseUrl + 'party';

}
