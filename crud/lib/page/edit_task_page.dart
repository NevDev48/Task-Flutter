import 'package:crud/data/datasources/task_remote_datasource.dart';
import 'package:crud/data/models/add_task_request_model.dart';
import 'package:crud/data/models/task_response_model.dart';
import 'package:crud/data/models/update_task_request_model.dart';
import 'package:flutter/material.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tittleController.text = widget.task.tittle;
    descriptionController.text = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        elevation: 2,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
            controller: tittleController,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
            controller: descriptionController,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final model = UpdateTaskRequestModel(
                id: int.parse(widget.task.id),
                tittle: tittleController.text,
                description: descriptionController.text, 
              );
              try {
                print('Model: ${model.toJson()}'); // Tambahkan log untuk debugging
                final response = await TaskRemoteDatasource().updateTask(model);
                // print(response.message); // Tambahkan log untuk debugging
                Navigator.pop(context, true); // Kembali dengan indikator sukses
              } catch (e) {
                print('Error: $e'); // Tangani kesalahan dengan menampilkan pesan
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to add task: $e')),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
