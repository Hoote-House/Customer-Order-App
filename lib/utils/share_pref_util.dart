import 'package:barista_apps/utils/hash_util.dart';
import 'package:barista_apps/utils/device_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefUtil {
  static SharedPreferences? prefs;

  static Future<String> getAddressHash() async {
    prefs ??= await SharedPreferences.getInstance();
    var addressHash = prefs?.getString("address_hash");
    return addressHash ?? "";
  }

  static Future<String> getDeviceChannel() async {
    prefs ??= await SharedPreferences.getInstance();
    var addressHash = prefs?.getString("device_channel");
    return addressHash ?? "";
  }

  static Future<void> setAddressHash(String value) async {
    prefs ??= await SharedPreferences.getInstance();
    var addressHash = prefs?.setString("address_hash", value);
    return;
  }

  static Future<void> setDeviceChannel(String value) async {
    prefs ??= await SharedPreferences.getInstance();
    var addressHash = prefs?.setString("device_channel", value);
    return;
  }
}
