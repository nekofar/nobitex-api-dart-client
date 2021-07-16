library nobitex;

import 'dart:convert';

import 'package:http/http.dart' as http;

class Nobitex {
  final String basePath;

  final String token;

  Nobitex({this.basePath = 'api.nobitex.ir', this.token = ''});

  /// Returns your profile information, bank card, bank account, verifications,
  /// profile settings and summary of your transaction statistics.
  Future<Map<String, dynamic>?> getProfile() async {
    var url = Uri.https(basePath, '/users/profile');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + token});

    return jsonDecode(response.body) as Map<String, dynamic>?;
  }

  /// Get a list of user wallets
  Future<Map<String, dynamic>?> getWallets() async {
    var url = Uri.https(basePath, '/users/wallets/list');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + token});

    return jsonDecode(response.body) as Map<String, dynamic>?;
  }

  /// Receive a list of deposits and withdrawals
  Future<Map<String, dynamic>?> getWalletRecords() async {
    var url = Uri.https(basePath, '/users/wallets/deposits/list');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + token});

    return jsonDecode(response.body) as Map<String, dynamic>?;
  }

  /// Generate or receive a blockchain address
  Future<Map<String, dynamic>?> getWalletAddress(
      {required String wallet}) async {
    var url = Uri.https(basePath, '/users/wallets/generate-address');

    var response = await http.post(url,
        headers: {'Authorization': 'Token ' + token}, body: {'wallet': wallet});

    return jsonDecode(response.body) as Map<String, dynamic>?;
  }

  /// Receive the balance of fiat and cryptocurrency wallets
  Future<Map<String, dynamic>?> getWalletBalance(
      {required String currency}) async {
    var url = Uri.https(basePath, '/users/wallets/balance');

    var response = await http.post(url,
        headers: {'Authorization': 'Token ' + token},
        body: {'currency': currency});

    return jsonDecode(response.body) as Map<String, dynamic>?;
  }
}
