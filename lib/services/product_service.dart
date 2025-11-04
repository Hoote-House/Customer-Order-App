import 'package:barista_apps/config/config.dart';
import 'package:barista_apps/models/category.dart';
import 'package:barista_apps/models/product.dart';
import 'package:dio/dio.dart';

class ProductService {
  Dio dio = Dio();
  static const baseUrl = AppConfig.apiUrl;

  Future<List<ProductCategory>> getAllProduct() async {
    try {
      final header = {"X-Device": "", "Device-Sign-Key": ""};

      final response = await dio.get(
        "$baseUrl/products",
        options: Options(headers: header),
      );

      if (response.statusCode != 200) throw Exception();

      final data = response.data["data"];

      List<ProductCategory> catgoriesWProduct = List.from(
        data.map((productCat) => ProductCategory.fromJson(productCat)),
      );

      return catgoriesWProduct;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductDetail> getProductDetail({required String id}) async {
    try {
      final header = {"X-Device": "", "Device-Sign-Key": ""};

      final response = await dio.get(
        "$baseUrl/products/$id",
        options: Options(headers: header),
      );

      if (response.statusCode != 200) throw Exception();

      final data = response.data["data"];

      ProductDetail product = ProductDetail.fromJson(
        data as Map<String, dynamic>,
      );

      return product;
    } catch (e) {
      rethrow;
    }
  }
}
