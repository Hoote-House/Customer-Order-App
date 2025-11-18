import 'package:barista_apps/config/config.dart';
import 'package:barista_apps/controllers/device_controller.dart';
import 'package:barista_apps/controllers/product_controller.dart';
import 'package:barista_apps/routes/app_route_named.dart';
import 'package:barista_apps/utils/device_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  final ProductController productC = Get.find<ProductController>(
    tag: 'products',
  );
  final DeviceController deviceC = Get.find<DeviceController>(tag: 'device');
  String deviceID = "";

  @override
  void initState() {
    super.initState();
    () async {
      var getDeviceID = await DeviceUtil.getDeviceID();
      setState(() {
        deviceID = getDeviceID;
      });

      await deviceC.checkInternet();
      if (deviceC.internetOk.value) {
        await productC.fetchProductCategory();
      }

      if (deviceC.deviceValid.value) Get.offAllNamed(AppRouteNamed.home);
    }();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => deviceC.internetOk.value ? _notRegistered() : _noInternet(),
        ),
      ),
    );
  }

  Center _noInternet() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(Icons.dangerous_sharp), Text("No Internet")],
    ),
  );

  Center _notRegistered() {
    return productC.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Device ID: $deviceID"),
                Text("Channel: ${AppConfig.deviceChannel}"),
                Text("Not Registered Or No Connection"),
                ElevatedButton.icon(
                  onPressed: () {
                    (() async => await productC.fetchProductCategory())();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.brown[700],
                  ),
                  label: Text("Retry", style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.refresh_rounded, color: Colors.white),
                ),
              ],
            ),
          );
  }
}
