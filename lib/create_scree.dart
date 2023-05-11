import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_database_testing_hive/QuickTask.dart';
import 'package:local_database_testing_hive/read_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final Box dataBox;
  final TextEditingController taskController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataBox = Hive.box('QuickTaskBox');
  }

  _createData() {
    QuickTask newData = QuickTask(
      tasktitle: taskController.text,
      taskdetails: taskDetailsController.text,
    );

    dataBox.add(newData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add New Your Task Here '),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: taskController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Title',
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: taskDetailsController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Description',
                labelText: 'Description',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _createData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReadScreen(),
                ),
              );
            },
            child: const Text('ADD DATA'),
          )
        ],
      ),
    );
  }
}
