import 'package:flutter_test/flutter_test.dart';
import 'package:dotenv/dotenv.dart' show load, env;

import 'package:nobitex/nobitex.dart';

void main() {
  load();

  final nobitex = Nobitex(token: env['NOBITEX_TOKEN'] as String);

  group('tests for Nobitex', () {
    test('test getProfile', () async {
      var data = await nobitex.getProfile();

      expect(data!.containsKey('profile'), true);
    });

    test('test getWallets', () async {
      var data = await nobitex.getWallets();

      expect(data!.containsKey('wallets'), true);
    });
  });
}
