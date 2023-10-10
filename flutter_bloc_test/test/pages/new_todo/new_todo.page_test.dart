import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/main.dart';
import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

void main() {
  late Uuid uuid;
  late Directory currentDirectory;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    uuid = const Uuid();
  });

  setUp(() async {
    currentDirectory = Directory('./test/isarpath/${uuid.v1()}');
    currentDirectory.create();
    isar = await Isar.open(
      [ToDoSchema],
      directory: currentDirectory.path,
      name: uuid.v1(),
    );
  });

  tearDown(() {
    currentDirectory.delete(recursive: true);
  });

  testWidgets('Should verify if new todo form was created',
      (widgetTester) async {
    var addButtonKey = const Key('AddTodoButton');

    await widgetTester.pumpWidget(const MyApp());

    expect(find.byKey(addButtonKey), findsOneWidget);
    await widgetTester.tap(find.byKey(addButtonKey));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('TitleInputTextField')), findsOneWidget);
    expect(find.byKey(const Key('DescriptionInputTextField')), findsOneWidget);
    expect(find.byKey(const Key('SaveTodoButton')), findsOneWidget);
  });
}
