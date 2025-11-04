import 'package:barista_apps/models/category.dart';
import 'package:barista_apps/models/product.dart';
import 'package:barista_apps/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var productsCat = <ProductCategory>[].obs;
  var productDetail = Rxn<ProductDetail>();
  var isLoading = true.obs;

  ProductService service = ProductService();

  Future<void> fetchProductCategory() async {
    try {
      isLoading(true);
      final prodCategory = await service.getAllProduct();

      productsCat.value = prodCategory;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductDetail({required String id}) async {
    try {
      isLoading(true);
      final product = await service.getProductDetail(id: id);

      productDetail.value = product;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
