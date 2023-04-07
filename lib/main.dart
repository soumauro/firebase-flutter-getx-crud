import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskes/appwidget.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   
  await 
   Firebase.initializeApp(options: 
  const FirebaseOptions(apiKey: "AIzaSyDrqISarGlnSOipK7dzWRuKeO6cdPgN8BY", 
       
  authDomain: "aulas-externas.firebaseapp.com",
  projectId: "aulas-externas",
  storageBucket: "aulas-externas.appspot.com",
  messagingSenderId: "430923921108",
  appId: "1:430923921108:web:158c44790b792e3a686d41"));
   
  runApp(const AppWidget());
}
