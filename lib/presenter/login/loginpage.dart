import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskes/presenter/login/logincontroler.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const router = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: 
    GetBuilder<Logincontroler>(
      builder: (controler) {
        return ElevatedButton(child: const  Text("entrar com google"), onPressed: () {
          controler.loginWithGoogle();
        }, );
      }
    ),),);
  }
}