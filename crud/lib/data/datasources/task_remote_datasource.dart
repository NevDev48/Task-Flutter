import 'dart:convert';
import 'dart:io';
import 'package:crud/data/models/add_task_request_model.dart';
import 'package:crud/data/models/add_task_response_model.dart';
import 'package:crud/data/models/task_response_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteDatasource {
  Future<TaskResponseModel> getTask() async {
    final response = await http.get(Uri.parse('http://192.168.56.2:80/recipe/saran/getData.php'));
    if (response.statusCode == 200) {
      return TaskResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load task');
    }
  }

  Future<AddTaskResponseModel> addTask(AddTaskRequestModel model) async {
    final response = await http.post(
      Uri.parse('http://192.168.56.2:80/recipe/saran/insertData.php'),
      body: jsonEncode(model.toJson()),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add task: ${response.reasonPhrase}'); // Tambahkan reasonPhrase untuk debugging
    }
  }

 Future<void> deleteTask(String id) async {
  final response = await http.delete(
    Uri.parse('http://192.168.56.2:80/recipe/saran/delData.php?id=$id'),
  );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  if (response.statusCode != 200) {
    throw Exception('Failed to delete task: ${response.reasonPhrase}');
  }
}

Future<AddTaskResponseModel> updateTask(String id, AddTaskRequestModel model) async {
  final response = await http.post(
    Uri.parse('http://192.168.56.2:80/recipe/saran/update.php?id=$id'),
    body: jsonEncode({
      'id': id,
      'tittle': model.tittle,
      'description': model.description,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    return AddTaskResponseModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update task: ${response.reasonPhrase}');
  }
}
}