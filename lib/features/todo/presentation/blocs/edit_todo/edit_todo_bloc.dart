import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:pepper_cloud_test/features/todo/domain/usecases/usecases.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({required SaveTodo saveTodo})
      : _saveTodo = saveTodo,
        super(const EditTodoState()) {
    on<EditTodoTitleChanged>(_onTitleChanged);
    on<EditTodoDescriptionChanged>(_onDescriptionChanged);
    on<EditTodoSubmitted>(_onSubmitted);
    on<EditTodoAddInitial>(_onAddInitial);
  }
  final SaveTodo _saveTodo;

  void _onAddInitial(
    EditTodoAddInitial event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(initialTodo: event.todo));
  }

  void _onTitleChanged(
    EditTodoTitleChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onDescriptionChanged(
    EditTodoDescriptionChanged event,
    Emitter<EditTodoState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  Future<void> _onSubmitted(
    EditTodoSubmitted event,
    Emitter<EditTodoState> emit,
  ) async {
    emit(state.copyWith(status: EditTodoStatus.loading));
    final res;
    if (state.isNewTodo) {
      res = await _saveTodo(
          Todo(title: state.title, description: state.description));
    } else {
      res = await _saveTodo(state.initialTodo!);
    }
    res.fold(
      (l) => emit(state.copyWith(
        status: EditTodoStatus.failure,
      )),
      (r) => emit(state.copyWith(
        status: EditTodoStatus.success,
      )),
    );
  }
}
