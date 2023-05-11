import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_database_testing_hive/create_scree.dart';
import 'package:local_database_testing_hive/update_screen.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  late final Box dataBox;

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('QuickTaskBox');
  }

  _deleteData(int index) {
    dataBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Task App'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: dataBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(
              child: Text('You have no task'),
            );
          } else {
            return ListView.builder(
              itemCount: dataBox.length,
              itemBuilder: (context, index) {
                var box = value;
                var getData = box.getAt(index);

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8.00, right: 8.00, top: 5.00, bottom: 5.00),
                  child: Card(
                    color: Colors.yellowAccent,
                    elevation: 5,
                    child: ListTile(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateScreen(
                                index: index,
                                data: getData,
                                titleController: getData.tasktitle,
                                descriptionController: getData.taskdetails,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      title: Text(getData.tasktitle),
                      subtitle: Text(getData.taskdetails),
                      trailing: IconButton(
                        onPressed: () {
                          _deleteData(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateScreen(),
          ),
        ),
      ),
    );
  }
}
