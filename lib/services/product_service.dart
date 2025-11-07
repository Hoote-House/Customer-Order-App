import 'package:barista_apps/config/config.dart';
import 'package:barista_apps/models/category.dart';
import 'package:barista_apps/models/product.dart';
import 'package:barista_apps/utils/device_util.dart';
import 'package:barista_apps/utils/hash_util.dart';
import 'package:dio/dio.dart';

class ProductService {
  Dio dio = Dio();
  static const baseUrl = AppConfig.apiUrl;

  Future<List<ProductCategory>> getAllProduct() async {
    var deviceID = await DeviceUtil.getDeviceID();
    var signKey = hashSHA512(
      deviceID + AppConfig.deviceChannel + AppConfig.apiKey,
    );

    try {
      final header = {
        "X-Device": "$deviceID:${AppConfig.deviceChannel}",
        "Device-Sign-Key": signKey,
      };

      final response = await dio.get(
        "$baseUrl/_device/products",
        options: Options(headers: header),
      );

      if (response.statusCode == 401) throw Exception("401");

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
    var deviceID = await DeviceUtil.getDeviceID();
    var signKey = hashSHA512(
      deviceID + AppConfig.deviceChannel + AppConfig.apiKey,
    );

    try {
      final header = {
        "X-Device": "$deviceID:${AppConfig.deviceChannel}",
        "Device-Sign-Key": signKey,
      };

      final response = await dio.get(
        "$baseUrl/_device/products/$id",
        options: Options(headers: header),
      );

      if (response.statusCode != 200) throw Exception();

      final data = response.data["data"];
      print(data);

      ProductDetail product = ProductDetail.fromJson(
        data as Map<String, dynamic>,
      );

      print(product);
      return product;
    } catch (e) {
      rethrow;
    }
  }
}
