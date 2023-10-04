import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/pages/home/bloc/home.event.dart';
import 'package:flutter_bloc_test/pages/home/bloc/home.state.dart';
import 'package:flutter_bloc_test/repositories/to_do_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _todoRepository = ToDoRepository();

  HomeBloc() : super(HomeInitialState()) {
    on<LoadTodoEvent>(
      (event, emit) async => emit(
        HomeSuccessState(
          todos: await _todoRepository.getAll(),
        ),
      ),
    );

    // on<AddClientEvent>(
    //   (event, emit) => emit(HomeSuccessState(clients: _clientRepo.addClient(event.client))),
    // );

    // on<RemoveClientEvent>(
    //   (event, emit) => emit(ClientSuccessState(clients: _clientRepo.removeClient(event.client))),
    // );
  }
}
