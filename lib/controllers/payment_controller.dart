import 'dart:async';
import 'dart:convert';

import 'package:barista_apps/config/config.dart';
import 'package:barista_apps/controllers/cart_controller.dart';
import 'package:barista_apps/models/payment.dart';
import 'package:barista_apps/services/payment_service.dart';
import 'package:barista_apps/utils/device_util.dart';
import 'package:barista_apps/utils/hash_util.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

typedef WSMessage = Map<String, dynamic>;

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var isPaid = false.obs;
  var qris = "".obs;

  WebSocketChannel? _channel;

  Timer? _reconnectTimer;
  int _retrySeconds = 1;
  bool _manuallyDisconnected = false;

  PaymentService service = PaymentService();
  CartController cartC = Get.find(tag: 'cart');

  @override
  void onInit() {
    super.onInit();
    _connect();
  }

  void _connect() async {
    var deviceID = await DeviceUtil.getDeviceID();
    var signKey = hashSHA512(
      deviceID + AppConfig.deviceChannel + AppConfig.apiKey,
    );

    final header = {
      "X-Device": "$deviceID:${AppConfig.deviceChannel}",
      "Device-Sign-Key": signKey,
    };

    final uri = Uri.parse(AppConfig.wsUrl);
    _channel = IOWebSocketChannel.connect(uri, headers: header);
    _channel?.stream
        .where((event) => event != null)
        .map((event) => jsonDecode(event) as WSMessage)
        .listen(
          onMessage,
          onDone: _handleDisconnect,
          onError: (err) {
            print("ERROR: $err");
            _handleDisconnect();
          },
        );
    print("connect!");
    _retrySeconds = 1;
  }

  void disconnect() {
    _manuallyDisconnected = true;
    _reconnectTimer?.cancel();
    _channel?.sink.close(status.goingAway);
  }

  void onMessage(message) {
    print("${message["message"]}");

    if (message["message"]["payment_status"] == "paid") {
      isPaid(true);
    }
  }

  void _handleDisconnect() {
    if (_manuallyDisconnected) return;

    _channel = null;
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(Duration(seconds: _retrySeconds), () {
      _connect();
      print("Retry: in ${_retrySeconds}s ");
      _retrySeconds = (_retrySeconds * 2).clamp(1, 2); // exponential backoff
    });
  }

  Future<void> requestPayment() async {
    try {
      isLoading(true);
      final request = PaymentRequest(
        paymentMethod: cartC.paymentSelected.value,
        items: cartC.cart,
      );

      final response = await service.requestPayment(request: request);

      switch (cartC.paymentSelected.value) {
        case 'qris':
          qris.value = response.qris;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
