import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/models/to_do.dart';
import 'package:flutter_bloc_test/pages/update_todo/cubits/update_todo_state.dart';
import 'package:flutter_bloc_test/repositories/to_do_repository.dart';

class UpdateTodoCubit extends Cubit<UpdateTodoState> {
  final ToDoRepository _repository;
  final ToDo task;

  UpdateTodoCubit({required this.task, ToDoRepository? repository})
      : _repository = repository ?? ToDoRepository(),
        super(EmptyState());

  Future<void> markAsDone() async {
    emit(LoadingState());
    task.done = !task.done;
    var result = await _repository.upsert(task);
    if (result == task.id) {
      emit(SuccessState());
    } else {
      emit(ErrorState(message: 'Error on update'));
    }
  }

  Future<void> saveUpdatedData() async {}

  Future<void> deleteTask() async {
    emit(LoadingState());
    var result = await _repository.deleteTask(task.id);
    if (result) {
      emit(SuccessState());
    } else {
      emit(ErrorState(message: 'Error on update'));
    }
  }
}
