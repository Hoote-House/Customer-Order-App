import 'package:barista_apps/config/config.dart';
import 'package:barista_apps/controllers/product_controller.dart';
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
  String deviceID = "";

  @override
  void initState() {
    super.initState();
    () async {
      var getDeviceID = await DeviceUtil.getDeviceID();
      setState(() {
        deviceID = getDeviceID;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Device ID: $deviceID"),
              Text("Channel: ${AppConfig.deviceChannel}"),
              Text("Not Registered Yet!"),
            ],
          ),
        ),
      ),
    );
  }
}
