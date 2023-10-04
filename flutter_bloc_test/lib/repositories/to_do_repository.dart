import 'package:flutter_bloc_test/main.dart';
import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:isar/isar.dart';

class ToDoRepository {
  static final ToDoRepository _singleton = ToDoRepository._internal();

  factory ToDoRepository() {
    return _singleton;
  }

  ToDoRepository._internal();

  Future<void> upsert(ToDo todo) async {
    await isar.writeTxn(() async {
      await isar.toDos.put(todo); // insert & update
    });
  }

  Future<List<ToDo>> getAll() async {
    return await isar.toDos.where().findAll();
  }
}
