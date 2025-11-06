import 'package:barista_apps/controllers/device_controller.dart';
import 'package:barista_apps/models/category.dart';
import 'package:barista_apps/models/product.dart';
import 'package:barista_apps/routes/app_route_named.dart';
import 'package:barista_apps/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productsCat = <ProductCategory>[].obs;
  var productDetail = Rxn<ProductDetail>();
  var isLoading = true.obs;
  var isDetailLoad = false.obs;

  var deviceC = Get.find<DeviceController>(tag: "device");

  ProductService service = ProductService();

  Future<void> fetchProductCategory() async {
    try {
      isLoading(true);
      final prodCategory = await service.getAllProduct();

      productsCat.value = prodCategory;
      deviceC.deviceValid(true);
    } catch (e) {
      if (e.toString() == "401") {
        Get.offAllNamed(AppRouteNamed.entry);
      }

      deviceC.deviceValid(false);
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductDetail({required String id}) async {
    try {
      isDetailLoad(true);
      final product = await service.getProductDetail(id: id);

      productDetail.value = product;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isDetailLoad(false);
    }
  }
}
