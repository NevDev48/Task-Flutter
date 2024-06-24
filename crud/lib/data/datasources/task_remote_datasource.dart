import 'dart:convert';
import 'dart:io';

import 'package:crud/data/models/add_task_request_model.dart';
import 'package:crud/data/models/add_task_response_model.dart';
import 'package:crud/data/models/task_response_model.dart';
import 'package:crud/data/models/update_task_request_model.dart';
import 'package:crud/data/models/update_task_response_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class TaskRemoteDatasource {
  Future<TaskResponseModel> getTask() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.9/saran/getData.php'));
    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<AddTaskResponseModel> addTask(AddTaskRequestModel model) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.9/saran/insertData.php'),
      body: jsonEncode(model.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add task: ${response.reasonPhrase}');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(
      Uri.parse('http://192.168.1.9/saran/delData.php?id=$id'),
    );
    print('Response body: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task: ${response.reasonPhrase}');
    }
  }

//   Future<AddTaskResponseModel> updateTask(String id, AddTaskRequestModel model) async {
//     // Validate input before sending request
//     if (model.tittle.isEmpty || model.description.isEmpty) {
//       throw Exception('All fields are required.');
//     }

//     final response = await http.post(
//       Uri.parse('http://192.168.1.9/saran/update.php/$id'),
//       // body: jsonEncode(model.toJson()),
//       // headers: {
//       //   'Content-Type': 'application/json',
//       // },
//     );

//     if (response.statusCode == 200) {
//       return AddTaskResponseModel.fromRawJson(response.body);
//     } else if (response.statusCode == 400) {
//       final errorResponse = jsonDecode(response.body);
//       throw Exception('Failed to update task: ${errorResponse["result"]}');
//     } else {
//       throw Exception('Failed to update task: ${response.reasonPhrase}');
//     }
//   }
// }
  Future<UpdateTaskResponseModel> updateTask(UpdateTaskRequestModel model) async {
    final response = await http.post(Uri.parse('http://192.168.1.9/saran/update.php'), body: jsonEncode(model.toJson()), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      // print('Response body: ${response.body}');
      return UpdateTaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to update task: ${response.reasonPhrase}');
    }
  }
}