import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taskes/infra/models/tasks_model.dart';
import 'package:taskes/presenter/home/home_controler.dart';
import 'package:taskes/presenter/shered/text_style.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  static const router = '/consteudo';
  final TextEditingController _dispesa = TextEditingController();
  final TextEditingController _valor = TextEditingController();
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('taskes');
  final formakey = GlobalKey<FormState>();
  AlertDialog dialog = const AlertDialog(
    title: Text('vamos'),
    actions: [
      Text("Sim"),
      Text("Nao"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
      ),
      body: GetBuilder<HomeControler>(builder: (controler) {
        return ListView(
          shrinkWrap: false,
          primary: false,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children:  [
                Card(
                  child: Text("total de itens ${controler.payment.totalItems}"),
                ),
                Card(
                  child: Text(" itens pagos ${controler.payment.paiditems}"),
                ),
                Card(
                  child: Text("itens por pagar ${controler.payment.itemsToPay} rs"),
                ),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                 Card(
                  child: Text("total pago ${controler.payment.paidmoney} rs"),
                ),
                ElevatedButton(
                    onPressed: () {
                      
                        showDialog(
                            context: context,
                            builder: (context) {
                              return dialog;
                            });
                      
                    },
                    child: const Text('Adicionar dispesa')),
                 Card(
                  child: Text("total por pagar ${controler.payment.forPayMony}"),
                ),
              ],
            ),
            StreamBuilder(
                stream:
                 _collectionReference.orderBy('valor').snapshots().map(
                    (event) => event.docs
                        .map((e) => 
                          TaskModel(
                            id: e.id,
                            title: e.get('title'),
                            valor: e.get('valor'),
                            status: e.get('status')))
                        .toList()),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    
                    List<Object?>? data = snapshot.data; 
                    return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: data!.length,
                        primary: true,
                        itemBuilder: (context, index) {
                          var item = data[index] as TaskModel;
                          return ListTile(
                            leading: IconButton(icon: const Icon(Icons.delete), 
                            onPressed: (){controler.delettetask(item.id);}, ),
                            title: Text(item.title),
                            subtitle: Text("${item.valor}"),
                            trailing: item.status? TextButton.icon(onPressed: () {controler.updatetask(item.id, item.status);}, 
                            icon: const Icon(Icons.done), label:const Text("Pago")):
                            TextButton.icon(onPressed: () {controler.updatetask(item.id, item.status);}, 
                            icon: const Icon(Icons.remove_circle), label:const Text("Nao Pago")) ,
                          );
                        });
                  }

                  return Text("${snapshot.data}");
                })),
            const SizedBox(
              height: 10,
            ),
            Form(
                key: formakey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _dispesa,
                      validator: (value) => value!.length < 4
                          ? "Insira uma dispesa valida "
                          : null,
                      decoration: textDecoretion,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        controller: _valor,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "Digite o valor da dispesa" : null,
                        decoration: textDecoretion.copyWith(
                            labelText: "Valor",
                            hintText: "digite o valor da dispesa"),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formakey.currentState!.validate()) {
                            controler
                                .addTask(TaskModel(
                                    title: _dispesa.text,
                                    valor: double.parse(_valor.text),
                                    status: false))
                                .then((value) =>
                                    {_dispesa.clear(), _valor.clear()});
                          }
                        },
                        child: const Text('Adicionar dispesa'))
                  ],
                )),
          ],
        );
      }),
    );
  }
}
