import 'package:crud/data/datasources/task_remote_datasource.dart';
import 'package:crud/data/models/add_task_request_model.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final tittlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        elevation: 2,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            controller: tittlecontroller,
            decoration: const InputDecoration(
              hintText: 'Tittle',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptioncontroller,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final model = AddTaskRequestModel(
                tittle: tittlecontroller.text,
                description: descriptioncontroller.text, 
              );
              try {
                final response = await TaskRemoteDatasource().addTask(model);
                print(response.message); // Tambahkan log untuk debugging
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
      )
    );
  }
}
