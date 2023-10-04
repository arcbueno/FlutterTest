import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:flutter_bloc_test/pages/home/home.page.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late final Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [ToDoSchema],
    directory: dir.path,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter test app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
