library nobitex;

import 'dart:convert';

import 'package:http/http.dart' as http;

class Nobitex {
  final String basePath;

  final String token;

  Nobitex({this.basePath = 'api.nobitex.ir', this.token = ''});

  Future<Map<String, dynamic>?> getProfile() async {
    var url = Uri.https(this.basePath, '/users/profile');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + this.token});

    return jsonDecode(response.body) as Map<String, dynamic>?;
  }

  Future<Map<String, dynamic>?> getWallets() async {
    var url = Uri.https(this.basePath, '/users/wallets/list');

    var response =
        await http.post(url, headers: {'Authorization': 'Token ' + this.token});

    return jsonDecode(response.body) as Map<String, dynamic>?;
  }
}
