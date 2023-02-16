
import 'package:flutter/material.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.tasks, required this.updatetask, required this.deletetask});
  final List tasks;
  final Function (String id) updatetask ;
  final Function (String id) deletetask ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(shrinkWrap: true, 
      itemCount: tasks.length ,itemBuilder: (context, index){
        var item = tasks[index];
      return  ListTile(leading:  CircleAvatar(backgroundColor: Colors.black,
      child: IconButton(onPressed: (){deletetask(item['id']);}, icon: const Icon(Icons.delete)),),
      title: Text("${item['data']['title']}"),
      subtitle: Text("${item['data']['valor']} reais"),
      trailing: !item['data']['status']? ElevatedButton(child: const Text('feito') , 
      onPressed: (){updatetask(item['id']);},
      ) : const Text('realizado'),
      );
    });
  }
}