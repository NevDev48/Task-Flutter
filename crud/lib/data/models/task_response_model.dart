import 'dart:convert';

class TaskResponseModel {
  final int status;
  final List<Task> data;

  TaskResponseModel({
    required this.status,
    required this.data,
  });

  factory TaskResponseModel.fromRawJson(String str) =>
      TaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      TaskResponseModel(
        status: json["status"],
        data: List<Task>.from(json["result"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Task {
  final String id;
  final String tittle;
  final String description;

  Task({
    required this.id,
    required this.tittle,
    required this.description,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        tittle: json["tittle"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tittle": tittle,
        "description": description,
      };
}
