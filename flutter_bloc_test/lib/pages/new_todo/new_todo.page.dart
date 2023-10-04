import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.bloc.dart';
import 'package:flutter_bloc_test/pages/new_todo/bloc/new_todo.state.dart';
import 'package:flutter_bloc_test/pages/new_todo/components/new_todo_form.dart';

class NewTodoPage extends StatefulWidget {
  const NewTodoPage({super.key});

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  late final NewTodoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = NewTodoBloc();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('New Todo'),
      ),
      body: BlocConsumer<NewTodoBloc, NewTodoState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == NewTodoStatus.success) Navigator.pop(context);
        },
        builder: (context, state) {
          return BlocProvider(
            create: (context) => bloc,
            child: Stack(
              children: [
                NewToDoForm(),
                if (state.status == NewTodoStatus.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
