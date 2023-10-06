import 'dart:io';

import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:flutter_bloc_test/repositories/to_do_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

void main() {
  late Isar isarTest;
  late Uuid uuid;
  late Directory currentDirectory;

  group('TodoRepository | ', () {
    setUpAll(() async {
      await Isar.initializeIsarCore(download: true);
      uuid = const Uuid();
    });

    setUp(() async {
      currentDirectory = Directory('./test/isarpath/${uuid.v1()}');
      currentDirectory.create();
      isarTest = await Isar.open(
        [ToDoSchema],
        directory: currentDirectory.path,
        name: uuid.v1(),
      );
    });

    tearDown(() {
      currentDirectory.delete(recursive: true);
    });

    test('Success on get all empty', () {
      final repoTest = ToDoRepository(isarTest);

      // Act
      var result = repoTest.getAll();

      // Assert
      expect(result, completion(isA<List<ToDo>>()));
      expect(result, completion(isEmpty));
    });

    test('Success on adding a new toDo', () {
      final repoTest = ToDoRepository(isarTest);

      // Act
      var resultCreated = repoTest.upsert(ToDo(title: 'teste1'));

      // Assert
      expect(resultCreated, completion(isA<int>()));
    });

    test('Getting new data after inputs with success', () async {
      final repoTest = ToDoRepository(isarTest);

      await repoTest.upsert(ToDo(title: 'teste1'));
      await repoTest.upsert(ToDo(title: 'teste2'));
      var resultGet = repoTest.getAll();

      expect(resultGet, completion(isNotEmpty));
    });
  });
}
