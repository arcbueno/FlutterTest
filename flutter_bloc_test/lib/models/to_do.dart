import 'package:isar/isar.dart';

part 'to_do.g.dart';

@collection
class ToDo {
  Id id = Isar.autoIncrement;
  late String title;
  String? description;
  bool done;

  ToDo({
    required this.title,
    this.description,
    this.done = false,
  });

  ToDo copyWith({
    String? title,
    String? description,
    bool? done,
  }) {
    return ToDo(
      title: title ?? this.title,
      description: description ?? this.description,
      done: done ?? this.done,
    );
  }
}
