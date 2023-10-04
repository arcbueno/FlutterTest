import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.event.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.state.dart';
import 'package:flutter_bloc_test/repositories/to_do_repository.dart';

class NewTodoBloc extends Bloc<NewTodoEvent, NewTodoState> {
  final _todoRepository = ToDoRepository();

  NewTodoBloc() : super(const NewTodoState()) {
    on<SavingTodoEvent>(_saveNewTodo);
  }

  _saveNewTodo(NewTodoEvent event, Emitter<NewTodoState> emit) async {
    if (event is! SavingTodoEvent) return;
    emit(state.copyWith(status: NewTodoStatus.loading));
    try {
      var newToDo = ToDo(title: event.title, description: event.description);
      await _todoRepository.upsert(newToDo);
      emit(state.copyWith(status: NewTodoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: NewTodoStatus.error, error: e.toString()));
    }
  }
}
