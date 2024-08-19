import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pepper_cloud_test/features/todo/presentation/blocs/todo_filter.dart';
import 'package:pepper_cloud_test/features/todo/presentation/blocs/todo_view/todo_view_bloc.dart';

class TodosViewFilterButton extends StatelessWidget {
  const TodosViewFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((TodosViewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TodosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: "Filter",
      onSelected: (filter) {
        context.read<TodosViewBloc>().add(TodosViewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: TodosViewFilter.all,
            child: Text("All"),
          ),
          PopupMenuItem(
            value: TodosViewFilter.activeOnly,
            child: Text("Active"),
          ),
          PopupMenuItem(
            value: TodosViewFilter.completedOnly,
            child: Text("Completed"),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
