import 'dart:convert';

class UpdateTaskRequestModel {
    final int? id;
    final String? tittle;
    final String? description;

    UpdateTaskRequestModel({
        this.id,
        this.tittle,
        this.description,
    });

    factory UpdateTaskRequestModel.fromRawJson(String str) => UpdateTaskRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UpdateTaskRequestModel.fromJson(Map<String, dynamic> json) => UpdateTaskRequestModel(
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
