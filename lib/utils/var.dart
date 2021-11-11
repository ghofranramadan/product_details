import 'package:shared_preferences/shared_preferences.dart';

class GetLAng {
  static String lang = '';
  static Future<String?> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString('locale')!;
    return prefs.getString('locale');
  }
}
