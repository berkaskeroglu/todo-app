import 'package:flutter/material.dart';
import 'package:mock_todo_app/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../providers/todo_provider.dart';
import '../widgets/todo_list.dart';
import 'add_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      _fabAnimationController.forward();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).fetchTodos();
    });
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 180.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'My Tasks',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppTheme.primaryColor, AppTheme.accentColor],
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                tooltip: 'Refresh',
                onPressed: () {
                  Provider.of<TodoProvider>(
                    context,
                    listen: false,
                  ).fetchTodos();
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Consumer<TodoProvider>(
                builder: (context, todoProvider, _) {
                  final completedCount =
                      todoProvider.todos
                          .where((todo) => todo.isCompleted)
                          .length;
                  final totalCount = todoProvider.todos.length;

                  return totalCount > 0
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tasks Overview',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(color: AppTheme.accentColor),
                              ),
                              Text(
                                '$completedCount of $totalCount completed',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (totalCount > 0)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value:
                                    totalCount > 0
                                        ? completedCount / totalCount
                                        : 0,
                                backgroundColor: AppTheme.dividerColor,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppTheme.accentColor,
                                ),
                                minHeight: 8,
                              ),
                            ),
                          const SizedBox(height: 16),
                        ],
                      )
                      : const SizedBox();
                },
              ),
            ),
          ),
          SliverFillRemaining(
            child: Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                return TodoList(
                  todos: todoProvider.todos,
                  isLoading: todoProvider.isLoading,
                  error: todoProvider.error,
                  onToggle: (todo) {
                    todoProvider.toggleTodoStatus(todo);
                  },
                  onDelete: (id) {
                    todoProvider.deleteTodo(id);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(
          parent: _fabAnimationController,
          curve: Curves.elasticOut,
        ),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddTodoScreen()),
            );
          },
          label: const Text('New Task'),
          icon: const Icon(Icons.add_circle_outline),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 6,
        ),
      ),
    );
  }
}
