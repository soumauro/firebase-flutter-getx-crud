import 'package:get/get.dart';
import 'package:taskes/presenter/login/logincontroler.dart';
 
class LoginBingings implements Bindings {
  @override
  void dependencies() {
    
    Get.put(Logincontroler());
  }
  
  
}