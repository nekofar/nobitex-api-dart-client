import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load;
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:nobitex/nobitex.dart';

void testMock() {
  load();

  final nobitex = Nobitex();

  group('mock tests for Nobitex', () {
    test('test getWalletAddress', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'status': 'ok',
              'address': 'LRf3vuTMy4UwD5b72G84hmkfGBQYJeTwUs'
            }),
            200,
            headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      });

      var data = await nobitex.getWalletAddress(wallet: '4159');

      expect(data!.containsKey('address'), true);
    });
  });
}
