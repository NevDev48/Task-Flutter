import 'dart:convert';

class AddTaskResponseModel {
  final int status;
  final String message;
  final String tittle;
  final String description;

  AddTaskResponseModel({
    required this.status,
    required this.message,
    required this.tittle,
    required this.description,
  });

  factory AddTaskResponseModel.fromRawJson(String str) => AddTaskResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) => AddTaskResponseModel(
    status: json["status"],
    message: json["message"],
    tittle: json["tittle"],
    description: json["description"],  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "tittle": tittle,
    "description": description,
  };
}
