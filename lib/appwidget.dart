import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
//import 'package:taskes/presenter/home/home_page.dart';
import 'package:taskes/presenter/login/loginpage.dart';
import 'package:taskes/router/router.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      initialRoute: LoginPage.router,
      getPages: AppPages.pages,
    );
  }
}