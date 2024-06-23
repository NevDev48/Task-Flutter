import 'package:crud/data/datasources/task_remote_datasource.dart';
import 'package:crud/data/models/task_response_model.dart';
import 'package:crud/page/edit_task_page.dart';
import 'package:crud/page/home_page.dart';
import 'package:flutter/material.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Task'),
        elevation: 2,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          Text('Tittle: ${widget.task.tittle}'),
          const SizedBox(height: 16),
          Text('Description: ${widget.task.description}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskPage(task: widget.task),
                    ),
                  );
                },
                child: const Text('Edit'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  // Show dialog confirmation delete
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure you want to delete this task?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                await TaskRemoteDatasource().deleteTask(widget.task.id);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              } catch (e) {
                                // Handle error
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to delete task: $e')),
                                );
                              }
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
