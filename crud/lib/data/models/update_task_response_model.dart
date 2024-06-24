import 'dart:convert';

class UpdateTaskResponseModel {
    final int? status;
    final String? result;

    UpdateTaskResponseModel({
        this.status,
        this.result,
    });

    factory UpdateTaskResponseModel.fromRawJson(String str) => UpdateTaskResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UpdateTaskResponseModel.fromJson(Map<String, dynamic> json) => UpdateTaskResponseModel(
        status: json["status"],
        result: json["result"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "result": result,
    };
}
