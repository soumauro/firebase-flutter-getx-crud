import 'package:taskes/presenter/home/home_bindings.dart';

import '../router/router_import.dart';
import "package:get/get.dart";
class AppPages {
   const AppPages._();
   static final pages = <GetPage>[
    GetPage(name: HomePage.router, page: () =>   HomePage(), binding: HomeBindigs())
   ];

  
}