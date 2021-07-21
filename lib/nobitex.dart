library nobitex;

import 'dart:convert';

import 'package:http/http.dart' as http;

class Nobitex {
  final String basePath;

  final String token;

  Nobitex({this.basePath = 'api.nobitex.ir', this.token = ''});

  /// Returns your profile information, bank card, bank account, verifications,
  /// profile settings and summary of your transaction statistics.
  getProfile() async {
    var url = Uri.https(basePath, '/users/profile');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + token});

    return jsonDecode(response.body);
  }

  /// Get a list of user wallets
  getWallets() async {
    var url = Uri.https(basePath, '/users/wallets/list');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + token});

    return jsonDecode(response.body);
  }

  /// Receive a list of deposits and withdrawals
  getWalletRecords() async {
    var url = Uri.https(basePath, '/users/wallets/deposits/list');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + token});

    return jsonDecode(response.body);
  }

  /// Generate or receive a blockchain address
  getWalletAddress({required String wallet}) async {
    var url = Uri.https(basePath, '/users/wallets/generate-address');

    var response = await http.post(url,
        headers: {'Authorization': 'Token ' + token}, body: {'wallet': wallet});

    return jsonDecode(response.body);
  }

  /// Receive the balance of fiat and cryptocurrency wallets
  getWalletBalance({required String currency}) async {
    var url = Uri.https(basePath, '/users/wallets/balance');

    var response = await http.post(url,
        headers: {'Authorization': 'Token ' + token},
        body: {'currency': currency});

    return jsonDecode(response.body);
  }
}
