part of 'todo_view_bloc.dart';

sealed class TodosViewEvent extends Equatable {
  const TodosViewEvent();

  @override
  List<Object> get props => [];
}

final class TodosViewSubscriptionRequested extends TodosViewEvent {
  const TodosViewSubscriptionRequested();
}

final class TodosViewTodoCompletionToggled extends TodosViewEvent {
  const TodosViewTodoCompletionToggled({
    required this.todo,
    required this.isCompleted,
  });

  final Todo todo;
  final bool isCompleted;

  @override
  List<Object> get props => [todo, isCompleted];
}

final class TodosViewTodoDeleted extends TodosViewEvent {
  const TodosViewTodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodosViewFilterChanged extends TodosViewEvent {
  const TodosViewFilterChanged(this.filter);

  final TodosViewFilter filter;

  @override
  List<Object> get props => [filter];
}
