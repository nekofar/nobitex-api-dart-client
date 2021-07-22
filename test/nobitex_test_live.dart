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

}
