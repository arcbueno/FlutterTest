import 'package:flutter_bloc_test/models/to_do.dart';

abstract class HomeEvent {}

class LoadTodoEvent extends HomeEvent {}

class RemoveClientEvent extends HomeEvent {
  ToDo client;

  RemoveClientEvent({
    required this.client,
  });
}
