import 'package:barista_apps/controllers/device_controller.dart';
import 'package:barista_apps/controllers/product_controller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    var device = Get.put<DeviceController>(
      DeviceController(),
      tag: 'device',
      permanent: true,
    );

    if (!device.internetOk.value) {
      return;
    }

    Get.put<ProductController>(
      ProductController(),
      tag: 'products',
      permanent: true,
    );
  }
}
