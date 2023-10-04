import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/models/to_do.dart';

class ToDoCard extends StatelessWidget {
  final ToDo todo;
  const ToDoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.amber.shade300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            if (todo.description != null)
              Expanded(
                child: Text(
                  todo.description!,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.fade,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
