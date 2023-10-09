import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:flutter_bloc_test/pages/update_todo/cubits/update_todo_cubit.dart';
import 'package:flutter_bloc_test/pages/update_todo/cubits/update_todo_state.dart';
import 'package:flutter_bloc_test/repositories/to_do_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ToDoRepositoryMock extends Mock implements ToDoRepository {}

void main() {
  final todo = ToDo(title: 'teste');
  todo.id = 0;
  todo.done = true;
  final repository = ToDoRepositoryMock();
  final cubit = UpdateTodoCubit(
    task: todo,
    repository: repository,
  );

  tearDown(() => reset(repository));

  group(
    'Update ToDo | Mark as done |',
    () {
      test(
        'Should mark task as done with success',
        () async {
          when(() => repository.upsert(todo)).thenAnswer((_) async => todo.id);

          expect(cubit.stream,
              emitsInOrder([isA<LoadingState>(), isA<SuccessState>()]));

          await cubit.markAsDone();
        },
      );

      test(
        'Should mark task as done with error',
        () async {
          when(() => repository.upsert(todo))
              .thenAnswer((_) async => todo.id + 1);

          expect(cubit.stream,
              emitsInOrder([isA<LoadingState>(), isA<ErrorState>()]));

          await cubit.markAsDone();
        },
      );
    },
  );

  group(
    'Update ToDo | Remove To Do |',
    () {
      test(
        'Should delete To Do with success',
        () async {
          when(() => repository.deleteTask(any()))
              .thenAnswer((_) async => true);

          expect(cubit.stream,
              emitsInOrder([isA<LoadingState>(), isA<SuccessState>()]));

          await cubit.deleteTask();
        },
      );

      test(
        'Should delete To Do with error',
        () async {
          when(() => repository.deleteTask(any()))
              .thenAnswer((_) async => false);

          expect(cubit.stream,
              emitsInOrder([isA<LoadingState>(), isA<ErrorState>()]));

          await cubit.deleteTask();
        },
      );
    },
  );
}
