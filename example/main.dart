import 'package:dotenv/dotenv.dart';
import 'package:nobitex/nobitex.dart';

void main() async {
  load();

  var nobitex = Nobitex(token: env['NOBITEX_TOKEN'] as String);

  var profile = await nobitex.getProfile();
  print(profile);
}
