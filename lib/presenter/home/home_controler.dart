//import 'dart:ffi';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskes/infra/models/payment_model.dart';
import 'package:taskes/infra/models/tasks_model.dart';

class HomeControler extends GetxController {
  @override
  void onReady() {
    super.onReady();
    calculos();
  }

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('taskes');

  List<TaskModel> taskes = [];
  Payment payment = Payment(
      totalItems: 0, paiditems: 0, itemsToPay: 0, forPayMony: 0, paidmoney: 0);

  String quirytype = "realizadas";
  double total = 0;
  upquery(String valor) {
    quirytype = valor;
    update();
    update();
  }

  Future calculos() async {
    payment = Payment(
      totalItems: 0, paiditems: 0, itemsToPay: 0, forPayMony: 0, paidmoney: 0);
    taskes = [];  
    await _collectionReference.get().then((value) => value.docs.forEach((e) {
          taskes.add(TaskModel(
              title: e.get('title'),
              valor: e.get('valor'),
              status: e.get('status')));
        }));
    payment.totalItems = taskes.length;
    payment.paiditems = taskes.where((element) => element.status == true).length;
    payment.itemsToPay = taskes.where((element) => element.status == false).length;
    taskes.forEach((element) => {
          if (element.status == true)
            { payment. paidmoney += element.valor}
          else
            {
              payment.forPayMony += element.valor,
            }
        });
  
    update();
  }


  List tasks = [];

  Future addTask(TaskModel data) async {
    await _collectionReference.add(data.toMap()).whenComplete(() => calculos());
  }

  Future updatetask(String ? id, bool status) async {
    
   await _collectionReference.doc(id).update({'status': !status});
    calculos();
  }

  Future delettetask(String ? id) async {
   await _collectionReference.doc(id).delete();
    calculos();
  }
}
