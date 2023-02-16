import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taskes/infra/models/tasks_model.dart';
import 'package:taskes/presenter/home/home_controler.dart';
import 'package:taskes/presenter/home/list_of_tasks.dart';
import 'package:taskes/presenter/shered/text_style.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  static const router = '/';
   final TextEditingController _dispesa = TextEditingController();
   final TextEditingController _valor = TextEditingController();
  final formakey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(title: const Text('home page'),),
    body: GetBuilder<HomeControler>(
      builder: (controler) {
        return ListView(children: [
           Visibility(visible: controler.tasks.isNotEmpty,
            child: TaskList(tasks: controler.tasks, updatetask: (String id) => controler.updatetask(id),deletetask:  (String id) => controler.delettetask(id),)),
          
      
          const SizedBox(height: 10,),
          Form(key: formakey,
            child: Column(children: [
            TextFormField( controller: _dispesa,
            validator: (value) => value!.length < 4  ? "kkkk exqueci como implementar REGEX " : null,
              decoration: textDecoretion,            
            ),
          const SizedBox(height: 10,),            
            TextFormField(controller: _valor,
            
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? "Digite o valor da dispesa" : null, 
            decoration: textDecoretion.copyWith(labelText: "Valor", hintText: "digite o valor da dispesa"),
              inputFormatters: [
                     FilteringTextInputFormatter.digitsOnly     
         ]),
          const SizedBox(height: 10,),            
          ElevatedButton(onPressed: (){if (formakey.currentState!.validate()) {
            controler.addTask(TaskModel(title: _dispesa.text, valor: double.parse(_valor.text), status: false)).then((value) => {_dispesa.clear(), _valor.clear()});
          }}, child: const Text('Adicionar dispesa'))
            
          ], )),
        ],);
      }
    ),
    );
  }
}