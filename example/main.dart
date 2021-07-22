import 'package:dotenv/dotenv.dart';
import 'package:nobitex/nobitex.dart';

void main() async {
  load();

  var nobitex = Nobitex();
  var profile = await nobitex.getProfile();

  print(profile);
}
