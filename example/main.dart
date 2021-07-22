import 'package:dotenv/dotenv.dart';
import 'package:nobitex/nobitex.dart';

void main() async {
  load();

  var nobitex = Nobitex();
  await nobitex.login(
      username: env['NOBITEX_USERNAME'].toString(),
      password: env['NOBITEX_PASSWORD'].toString());

  var profile = await nobitex.getProfile();
  print(profile);
}
