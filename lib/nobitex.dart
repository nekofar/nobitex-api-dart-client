library nobitex;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;

/// Wrapper class for Nobitex REST API.
class Nobitex {
  /// HTTP client that is used for the communication over the REST API.
  Client client = Client();

  /// Url to use for the REST requests.
  String basePath;

  /// Default HTTP headers for all requests.
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  /// Constructor of the API wrapper for communication.
  Nobitex({this.basePath = 'api.nobitex.ir'});

  /// Receive authentication token by username and password
  Future<void> login(
      {required String username,
      required String password,
      String? totp}) async {
    if (headers[HttpHeaders.authorizationHeader] != null) {
      return;
    }

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
    if (result['status'] != null && result['status'] == 'success') {
      headers[HttpHeaders.authorizationHeader] = 'Token ' + result['key'];
    }
  }

  /// Returns your profile information, bank card, bank account, verifications,
  /// profile settings and summary of your transaction statistics.
  Future<Map<String, dynamic>?> getProfile() async {
    var url = Uri.https(basePath, '/users/profile');

    var response = await client.post(url, headers: headers);

    return jsonDecode(response.body);
  }

  /// Returns your profile information, bank card, bank account, verifications,
  /// profile settings and summary of your transaction statistics.
  Future<Map<String, dynamic>?> getMarketStats(
      {required String srcCurrency, required String dstCurrency}) async {
    var url = Uri.https(basePath, '/market/stats');

    var response = await client.post(url,
        headers: headers,
        body: jsonEncode(
            {'srcCurrency': srcCurrency, 'dstCurrency': dstCurrency}));

    return jsonDecode(response.body);
  }

  /// Get a list of user wallets
  Future<Map<String, dynamic>?> getWallets() async {
    var url = Uri.https(basePath, '/users/wallets/list');

    var response = await client.post(url, headers: headers);

    return jsonDecode(response.body);
  }

  /// Receive a list of deposits and withdrawals
  Future<Map<String, dynamic>?> getWalletRecords() async {
    var url = Uri.https(basePath, '/users/wallets/deposits/list');

    var response = await client.post(url, headers: headers);

    return jsonDecode(response.body);
  }

  /// Generate or receive a blockchain address
  Future<Map<String, dynamic>?> getWalletAddress(
      {required String wallet}) async {
    var url = Uri.https(basePath, '/users/wallets/generate-address');

    var response = await client.post(url,
        headers: headers, body: jsonEncode({'wallet': wallet}));

    return jsonDecode(response.body);
  }

  /// Receive the balance of fiat and cryptocurrency wallets
  Future<Map<String, dynamic>?> getWalletBalance(
      {required String currency}) async {
    var url = Uri.https(basePath, '/users/wallets/balance');

    var response = await client.post(url,
        headers: headers, body: jsonEncode({'currency': currency}));

    return jsonDecode(response.body);
  }
}
