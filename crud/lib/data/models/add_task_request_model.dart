import 'dart:convert';

class AddTaskRequestModel {
  final String tittle;
  final String description;

  AddTaskRequestModel({
    required this.tittle,
    required this.description,
  });

  factory AddTaskRequestModel.fromRawJson(String str) =>
      AddTaskRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddTaskRequestModel.fromJson(Map<String, dynamic> json) => AddTaskRequestModel(
        tittle: json["tittle"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "tittle": tittle,
        "description": description,
      };
}
