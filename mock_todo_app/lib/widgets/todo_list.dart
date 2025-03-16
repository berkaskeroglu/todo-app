import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../utils/app_theme.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final bool isLoading;
  final String error;
  final Function(Todo) onToggle;
  final Function(int) onDelete;

  const TodoList({
    super.key,
    required this.todos,
    required this.isLoading,
    required this.error,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppTheme.primaryColor),
            const SizedBox(height: 16),
            Text(
              'Loading your tasks...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    if (error.isNotEmpty) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: AppTheme.primaryColor,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Oops! Something went wrong',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                error,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.grey.shade400,
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No tasks yet',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to create a new task',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TodoListItem(
            todo: todo,
            onToggle: onToggle,
            onDelete: onDelete,
          ),
        );
      },
    );
  }
}

class TodoListItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onToggle;
  final Function(int) onDelete;

  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: const Radius.circular(16),
          bottom: const Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Dismissible(
        key: Key(todo.id.toString()),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.delete, color: AppTheme.primaryColor),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => onDelete(todo.id),
        child: InkWell(
          borderRadius: BorderRadius.vertical(
            top: const Radius.circular(16),
            bottom: const Radius.circular(16),
          ),
          onTap: () => onToggle(todo),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () => onToggle(todo),
                  borderRadius: BorderRadius.circular(24),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          todo.isCompleted
                              ? AppTheme.accentColor
                              : Colors.transparent,
                      border: Border.all(
                        color:
                            todo.isCompleted
                                ? AppTheme.accentColor
                                : AppTheme.dividerColor,
                        width: 2,
                      ),
                    ),
                    child:
                        todo.isCompleted
                            ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                            : null,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          decoration:
                              todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                          color:
                              todo.isCompleted
                                  ? AppTheme.textLightColor
                                  : AppTheme.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (todo.description.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            todo.description,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              decoration:
                                  todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                              color:
                                  todo.isCompleted
                                      ? AppTheme.textLightColor
                                      : AppTheme.textLightColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
