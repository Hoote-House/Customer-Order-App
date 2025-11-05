import 'package:barista_apps/utils/hash_util.dart';
import 'package:barista_apps/utils/share_pref_util.dart';
import 'package:uuid/uuid.dart';

class DeviceUtil {
  static Future<String> getDeviceID() async {
    var deviceID = await SharePrefUtil.getAddressHash();

    if (deviceID.isEmpty) {
      var uuid = Uuid();
      deviceID = hashMD5(uuid.v4());

      await SharePrefUtil.setAddressHash(deviceID);
    }

    return deviceID;
  }
}
