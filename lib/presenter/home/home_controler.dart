import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskes/infra/models/tasks_model.dart';
class HomeControler extends GetxController {
  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('taskes');
  List tasks = [];
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    readTasks();
  }


Future readTasks ()async{
  var result =await _collectionReference.get().then((val) => val.docs);
  tasks = result.map((e) => {'id': e.id, 'data': e.data()} ).toList();
  update();
  
}
Future addTask (TaskModel data)async{
  await _collectionReference.add(data.toMap())
  .then((value) => readTasks() );
}

Future updatetask (String id)async{
  
 await _collectionReference.doc(id).update({'status':false});
 readTasks();
}
Future delettetask (String id)async{
  
 // _collectionReference.doc("GqTtULzGa0oa8muMz3xl").update({'status':false});
  _collectionReference.doc(id).delete();
  readTasks();
}


   
 }

  