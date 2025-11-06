import 'package:barista_apps/bindings/root_binding.dart';
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
      initialBinding: RootBinding(),
      initialRoute: AppRouteNamed.entry,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18.0), // Default for most body text
          headlineSmall: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ), // For headlines
          titleMedium: TextStyle(fontSize: 20.0), // For titles
          // Define other text styles as needed
        ),
      ),
    );
  }
}
