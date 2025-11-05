import 'package:barista_apps/routes/app_route.dart';
import 'package:barista_apps/routes/app_route_named.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(OrderCustomerCast());
}

class OrderCustomerCast extends StatelessWidget {
  const OrderCustomerCast({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Order Customer Cast',
      debugShowCheckedModeBanner: false,
      getPages: AppRoute.routes,
      initialRoute: AppRouteNamed.entry,
    );
  }
}
