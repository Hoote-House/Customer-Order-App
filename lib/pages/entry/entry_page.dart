import 'package:barista_apps/utils/device_util.dart';
import 'package:flutter/material.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  String address = "";
  void getMac() async {
    var mac = await DeviceUtil.getDeviceID();
    setState(() {
      address = mac;
    });
  }

  @override
  void initState() {
    super.initState();
    getMac();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("MAC: $address")));
  }
}
