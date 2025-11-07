import 'dart:io';

import 'package:get/get.dart';

class DeviceController extends GetxController {
  var deviceValid = false.obs;
  var internetOk = false.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internetOk(true);
        print(result);
      }
    } on SocketException catch (_) {
      internetOk(false);
    }
  }
}
