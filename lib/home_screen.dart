import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:local_database_testing_hive/QuickTask.dart';
import 'package:local_database_testing_hive/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _title = TextEditingController();
  final _author = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QuickTask App"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<QuickTask>('QuickTaskBox').listenable(),
        builder: (context, Box<QuickTask> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text("No Task Right Now"));
          } else {
            return ListView.separated(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                var result = box.getAt(index);

                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        addNewBook(context, index);
                      },
                    ),
                    title: Text(result!.tasktitle!),
                    subtitle: Text(result.taskdetails!),
                    trailing: InkWell(
                      child: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        box.deleteAt(index);
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(height: 12);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => addNewBook(context, DateTime.now().toString()),
      ),
    );
  }

  addNewBook(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("New Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _title,
                  decoration: const InputDecoration(hintText: 'Task Title'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _author,
                  decoration: const InputDecoration(hintText: 'Task Details'),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await box!.put(
                          index,
                          QuickTask(
                            tasktitle: _title.text,
                            taskdetails: _author.text,
                          ));

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    child: const Text("Add")),
              ],
            ),
          );
        });
  }
}
