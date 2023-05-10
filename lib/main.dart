import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:local_database_testing_hive/splash_screen.dart';

import 'QuickTask.dart';

Box? quickTaskbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  quickTaskbox = await Hive.openBox<QuickTask>("QuickTaskBox");
  runApp(const QuickTaskApp());
}

class QuickTaskApp extends StatelessWidget {
  const QuickTaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Scribble E-Commerce App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen());
  }
}
