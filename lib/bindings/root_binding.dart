import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/controllers/device_controller.dart';
import 'package:barista_apps/controllers/product_controller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<DeviceController>(
      DeviceController(),
      tag: 'device',
      permanent: true,
    );

    Get.put<CartController>(CartController(), tag: 'cart', permanent: true);

    Get.put<ProductController>(
      ProductController(),
      tag: 'products',
      permanent: true,
    );
  }
}
