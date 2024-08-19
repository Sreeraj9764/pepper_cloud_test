import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pepper_cloud_test/core/di/di_container.dart';
import 'package:pepper_cloud_test/core/extentions/context_extentions.dart';
import 'package:pepper_cloud_test/features/todo/presentation/blocs/todo_view/todo_view_bloc.dart';
import 'package:pepper_cloud_test/features/todo/presentation/pages/todo_edit_page.dart';
import 'package:pepper_cloud_test/features/todo/presentation/widgets/todo_list_tile.dart';
import 'package:pepper_cloud_test/features/todo/presentation/widgets/todos_overview_filter_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<TodosViewBloc>()..add(const TodosViewSubscriptionRequested()),
      child: const TodosViewView(),
    );
  }
}

class TodosViewView extends StatelessWidget {
  const TodosViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        actions: const [
          TodosViewFilterButton(),
        ],
      ),
      body: BlocListener<TodosViewBloc, TodosViewState>(
        listener: (context, state) {
          if (state.status == TodosViewStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.message ?? "failed"),
                ),
              );
          }
        },
        child: BlocBuilder<TodosViewBloc, TodosViewState>(
          builder: (context, state) {
            if (state.todos.isEmpty) {
              if (state.status == TodosViewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != TodosViewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    "Todo list is empty",
                    style: context.textTheme.displayMedium,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final todo in state.filteredTodos)
                    TodoListTile(
                      id: todo.id!,
                      isCompleted: todo.isCompleted,
                      title: todo.title,
                      description: todo.description,
                      dateTime: todo.dateTime,
                      onToggleCompleted: (isCompleted) {
                        context.read<TodosViewBloc>().add(
                              TodosViewTodoCompletionToggled(
                                todo: todo,
                                isCompleted: isCompleted,
                              ),
                            );
                      },
                      onDismissed: (_) {
                        context
                            .read<TodosViewBloc>()
                            .add(TodosViewTodoDeleted(todo));
                      },
                      onTap: () {
                        Navigator.of(context).push(
                          EditTodoPage.route(initialTodo: todo),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(EditTodoPage.route())),
    );
  }
}
