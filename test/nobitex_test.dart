import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load;
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:nobitex/nobitex.dart';

void main() {
  load();

  final nobitex = Nobitex();

  group('tests for Nobitex', () {
    test('test login', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'status': 'success',
              'key': 'db2055f743c1ac8c30d23278a496283b1e2dd46f',
              'device': 'AlRyansW'
            }),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
      });

      await nobitex.login(
          username: 'name@example.com', password: 'secret-password-1234');

      expect(nobitex.headers[HttpHeaders.authorizationHeader],
          'Token db2055f743c1ac8c30d23278a496283b1e2dd46f');
    });

    test('test getMarketStats', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'stats': {
                'btc-rls': {
                  'bestSell': '749976360.0000000000',
                  'isClosed': false,
                  'dayOpen': '686021860.0000000000',
                  'dayHigh': '750350000.0000000000',
                  'bestBuy': '733059600.0000000000',
                  'volumeSrc': '0.2929480000',
                  'dayLow': '686021860.0000000000',
                  'latest': '750350000.0000000000',
                  'volumeDst': '212724856.0678640000',
                  'dayChange': '9.38',
                  'dayClose': '750350000.0000000000'
                }
              },
              'status': 'ok'
            }),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
      });

      var data =
          await nobitex.getMarketStats(srcCurrency: 'btc', dstCurrency: 'rls');

      expect(data!.containsKey('stats'), true);
      expect(data['stats']['btc-rls']['isClosed'], false);
    });

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
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
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
            }),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
      });

      var data = await nobitex.getWallets();

      expect(data!.containsKey('wallets'), true);
      expect(data['wallets'][0]['rialBalance'], 51322935);
    });

    test('test getWalletRecords', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'status': 'ok',
              'deposits': [
                {
                  'txHash':
                      'c5d84268a0bf02307b5a0460a68b61987a9b3009d3a82a817e41558e619ec1d2',
                  'address': '32KfyTNh162UoKithfDrWHZPYq5uePGmf7',
                  'confirmed': true,
                  'transaction': {
                    'id': 10,
                    'amount': '3.0000000000',
                    'currency': 'btc',
                    'description':
                        'Deposit - address:36n452uGq1x4mK7bfyZR8wgE47AnBb2pzi, tx:c5d84268a0bf02307b5a0460a68b61987a9b3009d3a82a817e41558e619ec1d2',
                    'created_at': '2018-11-06T03:56:18+00:00',
                    'calculatedFee': '0'
                  },
                  'currency': 'Bitcoin',
                  'blockchainUrl':
                      'https://btc.com/c5d84268a0bf02307b5a0460a68b61987a9b3009d3a82a817e41558e619ec1d2',
                  'confirmations': 2,
                  'requiredConfirmations': 3,
                  'amount': '3.0000000000'
                }
              ],
              'withdraws': [
                {
                  'id': 2398,
                  'blockchain_url':
                      'https://live.blockcypher.com/ltc/tx/c1ed4229e598d4cf81e99e79fb06294a70af39443e2639e22c69bc30d6ecda67/',
                  'is_cancelable': false,
                  'status': 'Done',
                  'amount': '1.0000000000',
                  'createdAt': '2018-10-04T12:59:38.196935+00:00',
                  'wallet_id': 4159,
                  'currency': 'ltc',
                  'address': 'Lgn1zc77mEjk72KvXPqyXq8K1mAfcDE6YR'
                }
              ]
            }),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
      });

      var data = await nobitex.getWalletRecords();

      expect(data!.containsKey('deposits'), true);
      expect(data['deposits'][0]['confirmed'], true);
    });

    test('test getWalletAddress', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({
              'status': 'ok',
              'address': 'LRf3vuTMy4UwD5b72G84hmkfGBQYJeTwUs'
            }),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
      });

      var data = await nobitex.getWalletAddress(wallet: '4159');

      expect(data!.containsKey('address'), true);
      expect(data['address'], 'LRf3vuTMy4UwD5b72G84hmkfGBQYJeTwUs');
    });

    test('test getWalletBalance', () async {
      nobitex.client = MockClient((request) async {
        return Response(
            json.encode({'balance': '10.2649975000', 'status': 'ok'}), 200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
            });
      });

      var data = await nobitex.getWalletBalance(currency: 'ltc');

      expect(data!.containsKey('balance'), true);
      expect(data['balance'], '10.2649975000');
    });
  });
}
