abstract class NewTodoEvent {}

class SavingTodoEvent extends NewTodoEvent {
  final String title;
  final String? description;
  SavingTodoEvent({
    required this.title,
    this.description,
  });
}
