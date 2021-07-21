import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;

import 'package:nobitex/nobitex.dart';

void main() {
  load();

  final nobitex = Nobitex(basePath: 'testnetapi.nobitex.ir');

  setUp(() async {
    await nobitex.login(
        username: env['NOBITEX_USERNAME'].toString(),
        password: env['NOBITEX_PASSWORD'].toString());
  });

  group('tests for Nobitex', () {
    test('test getProfile', () async {
      var data = await nobitex.getProfile();

      expect(data!.containsKey('profile'), true);
    });

    test('test getWallets', () async {
      var data = await nobitex.getWallets();

      expect(data!.containsKey('wallets'), true);
    });

    test('test getWalletRecords', () async {
      var data = await nobitex.getWalletRecords();

      expect(data!.containsKey('deposits'), true);
    });

    test('test getWalletAddress', () async {
      var data = await nobitex.getWalletAddress(
          wallet: env['NOBITEX_WALLET'].toString());

      expect(data!.containsKey('address'), true);
    });

    test('test getWalletBalance', () async {
      var data = await nobitex.getWalletBalance(currency: 'ltc');

      expect(data!.containsKey('balance'), true);
    });
  });
}
