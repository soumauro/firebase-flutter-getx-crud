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
          Wrap(children: [
          ListTile(title: const Text('todas as dispesas'), leading: Radio(value: "realizadas",
           groupValue: controler.quirytype, onChanged: (val){controler.upquery(val!);
           controler.readTasks();
           }),),
          ListTile(title: const Text('dispesas pagas'), leading: Radio(value: "pogas",
           groupValue: controler.quirytype, onChanged: (val){controler.upquery(val!);
           controler.pagas(true);}),),
          ListTile(title: const Text('dispesas por pagar '), leading: Radio(value: "por pagar",
           groupValue: controler.quirytype, onChanged: (val){controler.upquery(val!);
           controler.pagas(false);}),),
          ],),
           Visibility(visible: controler.tasks.isNotEmpty,
            child: 
            Column(
              children: [
                TaskList(tasks: controler.tasks, updatetask: (String id) => controler.updatetask(id),deletetask:  (String id) => controler.delettetask(id),),
               Card(color: Colors.greenAccent, child: ListTile( leading: const Text("Total"), trailing: Text("${controler.total} Mtn"),))
              ],
            )),
          
      
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