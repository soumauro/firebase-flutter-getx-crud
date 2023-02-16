import 'package:get/get.dart';
import 'package:taskes/presenter/home/home_controler.dart';

class HomeBindigs implements Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => HomeControler());
  }
  
}