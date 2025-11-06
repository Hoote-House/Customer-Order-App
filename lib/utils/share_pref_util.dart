import 'package:shared_preferences/shared_preferences.dart';

class SharePrefUtil {
  static SharedPreferences? prefs;

  static Future<String> getAddressHash() async {
    prefs ??= await SharedPreferences.getInstance();
    var addressHash = prefs?.getString("address_hash");
    return addressHash ?? "";
  }

  static Future<void> setAddressHash(String value) async {
    prefs ??= await SharedPreferences.getInstance();
    var addressHash = prefs?.setString("address_hash", value);
    return;
  }
}
