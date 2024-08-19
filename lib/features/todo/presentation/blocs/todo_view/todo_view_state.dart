part of 'todo_view_bloc.dart';

enum TodosViewStatus { initial, loading, success, failure }

final class TodosViewState extends Equatable {
  const TodosViewState(
      {this.status = TodosViewStatus.initial,
      this.todos = const [],
      this.filter = TodosViewFilter.all,
      this.message});

  final TodosViewStatus status;
  final List<Todo> todos;
  final TodosViewFilter filter;
  final String? message;
  Iterable<Todo> get filteredTodos => filter.applyAll(todos);

  TodosViewState copyWith(
      {TodosViewStatus? status,
      List<Todo>? todos,
      TodosViewFilter? filter,
      String? message}) {
    return TodosViewState(
        status: status ?? this.status,
        todos: todos ?? this.todos,
        filter: filter ?? this.filter,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        status,
        todos,
        filter,
      ];
}
