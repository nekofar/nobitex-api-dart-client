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
    test('test getProfile', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'status': 'ok',
              'profile': {
                'firstName': 'مهدی',
                'lastName': 'رضایی',
                'nationalCode': '011122333',
                'email': 'name@example.com',
                'username': 'name@example.com',
                'phone': '02142719000-9012',
                'mobile': '09151111111',
                'city': 'مشهد',
                'bankCards': [
                  {
                    'number': '6037-9900-0000-0000',
                    'bank': 'ملی',
                    'owner': 'مهدی رضایی',
                    'confirmed': true,
                    'status': 'confirmed'
                  }
                ],
                'bankAccounts': [
                  {
                    'id': 1999,
                    'number': '0346666666666',
                    'shaba': 'IR460170000000346666666666',
                    'bank': 'ملی',
                    'owner': 'مهدی رضایی',
                    'confirmed': true,
                    'status': 'confirmed'
                  }
                ],
                'verifications': {
                  'email': true,
                  'phone': true,
                  'mobile': true,
                  'identity': true,
                  'selfie': false,
                  'bankAccount': true,
                  'bankCard': true,
                  'address': true,
                  'city': true
                },
                'pendingVerifications': {
                  'email': false,
                  'phone': false,
                  'mobile': false,
                  'identity': false,
                  'selfie': false,
                  'bankAccount': false,
                  'bankCard': false
                },
                'options': {
                  'fee': '0.35',
                  'feeUsdt': '0.2',
                  'isManualFee': false,
                  'tfa': false,
                  'socialLoginEnabled': false
                },
                'withdrawEligible': true
              },
              'tradeStats': {
                'monthTradesTotal': '10867181.5365000000',
                'monthTradesCount': 3
              }
            }),
            200,
            headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
      });

      var data = await nobitex.getProfile();

      expect(data!.containsKey('profile'), true);
      expect(data['profile']['email'], 'name@example.com');
    });

    test('test getWallets', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'status': 'ok',
              'wallets': [
                {
                  'activeBalance': '10.2649975000',
                  'blockedBalance': '0',
                  'user': 'name@example.com',
                  'currency': 'ltc',
                  'id': 4159,
                  'balance': '10.2649975000',
                  'rialBalance': 51322935,
                  'rialBalanceSell': 52507310,
                  'depositAddress': null
                },
              ]
            }
            ),
            200,
            headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
      });

      var data = await nobitex.getWallets();

      expect(data!.containsKey('wallets'), true);
      expect(data['wallets'][0]['rialBalance'], 51322935);
    });

    test('test getWalletAddress', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'status': 'ok',
              'address': 'LRf3vuTMy4UwD5b72G84hmkfGBQYJeTwUs'
            }),
            200,
            headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'});
      });

      var data = await nobitex.getWalletAddress(wallet: '4159');

      expect(data!.containsKey('address'), true);
      expect(data['address'], 'LRf3vuTMy4UwD5b72G84hmkfGBQYJeTwUs');
    });
  });
}
