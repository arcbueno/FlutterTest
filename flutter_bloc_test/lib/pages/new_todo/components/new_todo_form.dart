import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.bloc.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.event.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.state.dart';
import 'package:flutter_bloc_test/utils/sized_box_extension.dart';

class NewToDoForm extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  NewToDoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTodoBloc, NewTodoState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  key: const Key('TitleInputTextField'),
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Title",
                    fillColor: Colors.white70,
                  ),
                ),
                12.height,
                TextField(
                  key: const Key('DescriptionInputTextField'),
                  controller: descriptionController,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Description",
                    fillColor: Colors.white70,
                  ),
                ),
                24.height,
                OutlinedButton(
                  key: const Key('SaveTodoButton'),
                  onPressed: () {
                    var success = (_formKey.currentState?.validate() ?? false);
                    if (success) {
                      context.read<NewTodoBloc>().add(
                            SavingTodoEvent(
                              title: titleController.text,
                              description: descriptionController.text,
                            ),
                          );
                    }
                  },
                  child: const Text(
                    'Save',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
