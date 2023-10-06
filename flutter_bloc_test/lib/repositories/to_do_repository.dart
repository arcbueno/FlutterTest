import 'package:flutter_bloc_test/main.dart';
import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:isar/isar.dart';

class ToDoRepository {
  final Isar _isar;

  ToDoRepository([Isar? newIsar]) : _isar = newIsar ?? isar;

  Future<int> upsert(ToDo todo) async {
    return await _isar.writeTxn(() async {
      return await _isar.toDos.put(todo); // insert & update
    });
  }

  Future<List<ToDo>> getAll() async {
    var result = await _isar.collection<ToDo>().where().findAll();
    return result;
  }
}
