library nobitex;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;

class Nobitex {
  Client client = Client();

  String basePath;

  String? token;

  Nobitex({this.basePath = 'api.nobitex.ir', this.token});

  login(
      {required String username,
      required String password,
      String? totp}) async {
    var url = Uri.https(basePath, '/auth/login/');

    var response = await client.post(url, headers: {
      'X-TOTP': totp ?? ''
    }, body: {
      'username': username,
      'password': password,
      'remember': 'yes',
      'captcha': 'api'
    });

    var result = jsonDecode(response.body);
    if (result['status'] == null) {
      return null;
    } else {
      if (result['status'] == 'success') {
        token = result['key'];
      } else {
        return null;
      }
    }
  }

  /// Returns your profile information, bank card, bank account, verifications,
  /// profile settings and summary of your transaction statistics.
  getProfile() async {
    var url = Uri.https(basePath, '/users/profile');

    var response = await client.post(url,
        headers: {HttpHeaders.authorizationHeader: 'Token ' + token!});

    return jsonDecode(response.body);
  }

  /// Get a list of user wallets
  getWallets() async {
    var url = Uri.https(basePath, '/users/wallets/list');

    var response = await client.post(url,
        headers: {HttpHeaders.authorizationHeader: 'Token ' + token!});

    return jsonDecode(response.body);
  }

  /// Receive a list of deposits and withdrawals
  getWalletRecords() async {
    var url = Uri.https(basePath, '/users/wallets/deposits/list');

    var response = await client.post(url,
        headers: {HttpHeaders.authorizationHeader: 'Token ' + token!});

    return jsonDecode(response.body);
  }

  /// Generate or receive a blockchain address
  getWalletAddress({required String wallet}) async {
    var url = Uri.https(basePath, '/users/wallets/generate-address');

    var response = await client.post(url,
        headers: {HttpHeaders.authorizationHeader: 'Token ' + token!},
        body: {'wallet': wallet});

    return jsonDecode(response.body);
  }

  /// Receive the balance of fiat and cryptocurrency wallets
  getWalletBalance({required String currency}) async {
    var url = Uri.https(basePath, '/users/wallets/balance');

    var response = await client.post(url,
        headers: {HttpHeaders.authorizationHeader: 'Token ' + token!},
        body: {'currency': currency});

    return jsonDecode(response.body);
  }
}
