import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pepper_cloud_test/core/usecase/usecase.dart';
import 'package:pepper_cloud_test/features/todo/domain/entities/todo.dart';
import 'package:pepper_cloud_test/features/todo/domain/usecases/usecases.dart';
import 'package:pepper_cloud_test/features/todo/presentation/blocs/todo_filter.dart';

part 'todo_view_event.dart';
part 'todo_view_state.dart';

class TodosViewBloc extends Bloc<TodosViewEvent, TodosViewState> {
  TodosViewBloc({
    required DeleteTodo deleteTodo,
    required GetTodos getTodos,
    required SaveTodo saveTodo,
  })  : _deleteTodo = deleteTodo,
        _getTodos = getTodos,
        _saveTodo = saveTodo,
        super(const TodosViewState()) {
    on<TodosViewSubscriptionRequested>(_onSubscriptionRequested);
    on<TodosViewTodoCompletionToggled>(_onTodoCompletionToggled);
    on<TodosViewTodoDeleted>(_onTodoDeleted);
    on<TodosViewFilterChanged>(_onFilterChanged);
  }

  final DeleteTodo _deleteTodo;
  final GetTodos _getTodos;
  final SaveTodo _saveTodo;

  Future<void> _onSubscriptionRequested(
    TodosViewSubscriptionRequested event,
    Emitter<TodosViewState> emit,
  ) async {
    emit(state.copyWith(status: TodosViewStatus.loading));
    await emit.forEach<List<Todo>>(
      _getTodos.call(NoParams()),
      onData: (todos) => state.copyWith(
        status: TodosViewStatus.success,
        todos: todos,
      ),
      onError: (_, __) => state.copyWith(
        status: TodosViewStatus.failure,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
    TodosViewTodoCompletionToggled event,
    Emitter<TodosViewState> emit,
  ) async {
    final newTodo = event.todo.copyWith(
      isCompleted: event.isCompleted,
    );
    await _saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(
    TodosViewTodoDeleted event,
    Emitter<TodosViewState> emit,
  ) async {
    final res = await _deleteTodo(event.todo.id!);
    res.fold(
      (l) => emit(state.copyWith(
        status: TodosViewStatus.failure,
        message: "Failed to delete",
      )),
      (r) => emit(state.copyWith(
        status: TodosViewStatus.success,
        message: "Successfully deleted",
      )),
    );
  }

  void _onFilterChanged(
    TodosViewFilterChanged event,
    Emitter<TodosViewState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }
}
