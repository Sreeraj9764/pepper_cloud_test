import 'package:flutter/material.dart';
import 'package:pepper_cloud_test/core/extentions/context_extentions.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('todoListTile_dismissible_$id'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: !isCompleted
              ? context.textTheme.titleLarge
              : context.textTheme.titleLarge?.copyWith(
                  decoration: TextDecoration.lineThrough,
                  
                ),
        ),
        subtitle: Text(
          description ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Checkbox(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: isCompleted,
          onChanged: onToggleCompleted == null
              ? null
              : (value) => onToggleCompleted!(value!),
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
