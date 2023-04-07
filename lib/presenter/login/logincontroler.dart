// ignore_for_file: unnecessary_null_comparison

import 'package:get/get.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskes/presenter/home/home_page.dart';

class Logincontroler extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if( FirebaseAuth.instance.currentUser!.uid != null ){
      Get.toNamed(HomePage.router);
    }; 
  }
  
  Future loginWithGoogle () async {
    final login = FirebaseAuth.instance;
    GoogleAuthProvider provider = GoogleAuthProvider();
    final entrar = await login.signInWithPopup(provider);

    // ignore: unnecessary_null_comparison
    if (entrar.user!.uid != null){
      Get.toNamed(HomePage.router);
    }

    
    

   

  }
  
}