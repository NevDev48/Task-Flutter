import 'package:crud/data/models/add_task_request_model.dart';
import 'package:crud/data/models/task_response_model.dart';
import 'package:crud/data/datasources/task_remote_datasource.dart';
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
  final tittleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tittleController.text = widget.task.tittle ?? '';
    descriptionController.text = widget.task.description ?? '';
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
              hintText: 'Tittle',
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
              final newModel = AddTaskRequestModel(
                tittle: tittleController.text,
                description: descriptionController.text,
              );

              if (widget.task.id != null && newModel.tittle != null && newModel.description != null) {
                try {
                  await TaskRemoteDatasource().updateTask(widget.task.id!, newModel);
                  Navigator.pop(context, true); // Kembali ke halaman sebelumnya dengan indikator sukses
                } catch (e) {
                  // Tangani error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update task: $e')),
                  );
                }
              } else {
                // Tampilkan pesan error jika ada nilai null
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('All fields are required.')),
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
