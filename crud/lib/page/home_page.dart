import 'package:crud/data/datasources/task_remote_datasource.dart';
import 'package:crud/data/models/task_response_model.dart';
import 'package:crud/page/add_task_page.dart';
import 'package:crud/page/detail_task_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;
  List<Task> task = [];

  Future<void> getTask() async {
    setState(() {
      isLoaded = true;
    });
    try {
      final model = await TaskRemoteDatasource().getTask();
      setState(() {
        task = model.data ?? [];
        isLoaded = false;
      });
    } catch (e) {
      setState(() {
        isLoaded = false;
      });
      // Handle the error accordingly
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load tasks: $e')),
      );
    }
  }

  @override
  void initState() {
    getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        elevation: 2,
        backgroundColor: Colors.green,
      ),
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailTaskPage(task: task[index],)));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(task[index].tittle),
                      subtitle: Text(task[index].description),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
              itemCount: task.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskPage()));
          if (result == true) { // Cek indikator sukses
            getTask();
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
