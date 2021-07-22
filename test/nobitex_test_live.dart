import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load, env;

import 'package:nobitex/nobitex.dart';

void testLive() {
  load();

  final nobitex = Nobitex(basePath: 'testnetapi.nobitex.ir');

  setUp(() async {
    await nobitex.login(
        username: env['NOBITEX_USERNAME'].toString(),
        password: env['NOBITEX_PASSWORD'].toString());
  });

  group('live tests for Nobitex', () {
    test('test getWalletRecords', () async {
      var data = await nobitex.getWalletRecords();

      expect(data!.containsKey('deposits'), true);
    });

    test('test getWalletBalance', () async {
      var data = await nobitex.getWalletBalance(currency: 'ltc');

      expect(data!.containsKey('balance'), true);
    });
  });
}
