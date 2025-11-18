import 'package:barista_apps/config/config.dart';
import 'package:barista_apps/models/payment.dart';
import 'package:barista_apps/utils/device_util.dart';
import 'package:barista_apps/utils/hash_util.dart';
import 'package:dio/dio.dart';

class PaymentService {
  final Dio dio = Dio();
  static const baseUrl = AppConfig.apiUrl;

  Future<PaymentResponse> requestPayment({
    required PaymentRequest request,
  }) async {
    var deviceID = await DeviceUtil.getDeviceID();
    var signKey = hashSHA512(
      deviceID + AppConfig.deviceChannel + AppConfig.apiKey,
    );

    try {
      final header = {
        "X-Device": "$deviceID:${AppConfig.deviceChannel}",
        "Device-Sign-Key": signKey,
      };

      final response = await dio.post(
        "$baseUrl/_device/orders/payment",
        options: Options(headers: header),
        data: request.toMap(),
      );

      if (response.statusCode != 200) throw Exception();

      final data = response.data["data"];
      print(data);

      PaymentResponse product = PaymentResponse.fromJson(
        data as Map<String, dynamic>,
      );

      return product;
    } catch (e) {
      rethrow;
    }
  }
}
