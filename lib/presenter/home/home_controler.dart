//import 'dart:ffi';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskes/infra/models/tasks_model.dart';
class HomeControler extends GetxController {
   String quirytype = "realizadas";
   double total = 0;
   upquery (String valor){
    quirytype =  valor;
    update();
    }
   
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('taskes');
  List tasks = [];
  @override
  void onReady() {
    // TODO: implement 
    super.onReady();
    readTasks();
  }
Future pagas (bool pagos) async {
  total = 0;
  var result = await _collectionReference.where('status', isEqualTo: pagos ).get().then((value) => value.docs);
  tasks = result.map((e) => {'id': e.id, 'data': e.data()} ).toList();
  result.forEach((element) {total += element.get('valor'); update();});
  update();
 }


Future readTasks ()async{
  var result =await _collectionReference.get().then((val) => val.docs);
  result.forEach((element) {total += element.get('valor'); update();});
  tasks = result.map((e) => {'id': e.id, 'data': e.data()} ).toList();
  update();
  
}
Future addTask (TaskModel data)async{
  await _collectionReference.add(data.toMap())
  .then((value) => readTasks() );
}

Future updatetask (String id)async{  
  var data = {'status': false};
  _collectionReference.doc(id).update({'status': true}); 
 readTasks();
}
Future delettetask (String id)async{
  
  _collectionReference.doc(id).delete();
  readTasks();
}


   
 }

  