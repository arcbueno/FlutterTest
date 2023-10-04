enum NewTodoStatus {
  initial,
  success,
  error,
  loading,
  selected;
}

class NewTodoState {
  final NewTodoStatus status;
  final String? error;

  const NewTodoState({
    this.status = NewTodoStatus.initial,
    this.error,
  });

  NewTodoState copyWith({
    NewTodoStatus? status,
    String? error,
  }) {
    return NewTodoState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
