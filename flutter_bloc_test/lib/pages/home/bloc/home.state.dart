import 'package:flutter_bloc_test/models/to_do.dart';

abstract class HomeState {
  List<ToDo> todos;

  HomeState({
    required this.todos,
  });
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(todos: []);
}

class HomeSuccessState extends HomeState {
  HomeSuccessState({required List<ToDo> todos}) : super(todos: todos);
}
