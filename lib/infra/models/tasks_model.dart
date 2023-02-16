import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class TaskModel {
  final String title;
  final double valor;
  bool status;
  TaskModel({
    required this.title,
    required this.valor,
    required this.status,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'valor': valor,
      'status': status,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] as String,
      valor: map['valor'] as double,
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskModel(title: $title, valor: $valor, status: $status)';
}
