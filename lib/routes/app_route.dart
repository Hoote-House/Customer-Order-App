import 'package:barista_apps/pages/home/home_page.dart';
import 'package:barista_apps/routes/app_route_named.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppRoute {
  static final routes = [
    GetPage(name: AppRouteNamed.home, page: () => HomePage()),
  ];
}
