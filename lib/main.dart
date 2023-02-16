import 'package:firebase_core/firebase_core.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskes/appwidget.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   
  await 
   Firebase.initializeApp(options: 
  const FirebaseOptions(apiKey: "AIzaSyDlTa1kw_qMBbwriNEyJf39UNZQY0mkBys", appId: "1:297009527743:web:cacb41eb52b7612abbbf0a", messagingSenderId: "297009527743", projectId: "strawte-9231b",));
     
   
  runApp(const AppWidget());
}
