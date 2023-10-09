sealed class UpdateTodoState {}

class EmptyState extends UpdateTodoState {}

class LoadingState extends UpdateTodoState {}

class SuccessState extends UpdateTodoState {}

class ErrorState extends UpdateTodoState {
  final String message;
  ErrorState({
    required this.message,
  });
}
