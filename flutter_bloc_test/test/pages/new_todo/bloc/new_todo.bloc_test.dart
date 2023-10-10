import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.bloc.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.event.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.state.dart';
import 'package:flutter_bloc_test/repositories/to_do_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ToDoRepositoryMock extends Mock implements ToDoRepository {}

void main() {
  test('Creating ToDo with success', () {
    final repoMock = ToDoRepositoryMock();
    // when(() => repoMock.upsert(any())).thenAnswer();

    final blocMock = NewTodoBloc(toDoRepository: repoMock);
    blocMock.add(SavingTodoEvent(title: ''));
    expect(
      blocMock.state.status,
      completion(NewTodoStatus.success),
    );
  });
}
