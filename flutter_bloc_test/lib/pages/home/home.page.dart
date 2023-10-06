import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/pages/home/bloc/home.bloc.dart';
import 'package:flutter_bloc_test/pages/home/bloc/home.event.dart';
import 'package:flutter_bloc_test/pages/home/bloc/home.state.dart';
import 'package:flutter_bloc_test/pages/home/components/to_do_card.dart';
import 'package:flutter_bloc_test/pages/new_todo/new_todo.page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc()..add(LoadTodoEvent());
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
        title: const Text('Flutter test app'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is HomeInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeSuccessState) {
            final todoList = state.todos;
            if (todoList.isEmpty) {
              return const Text(
                '😢📭',
                style: TextStyle(
                  fontSize: 40,
                ),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return ToDoCard(
                  todo: todoList[index],
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('AddTodoButton'),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const NewTodoPage();
              },
            ),
          );
          bloc.add(LoadTodoEvent());
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
