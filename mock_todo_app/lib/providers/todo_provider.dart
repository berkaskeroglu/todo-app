import 'package:flutter/foundation.dart';

import '../models/todo_model.dart';
import '../services/api_service.dart';

class TodoProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Todo> _todos = [];
  bool _isLoading = false;
  String _error = '';

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchTodos() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _todos = await _apiService.getTodos();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addTodo(String title, String description) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        description: description,
      );

      final createdTodo = await _apiService.createTodo(newTodo);
      _todos.add(createdTodo);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> toggleTodoStatus(Todo todo) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
      await _apiService.updateTodo(updatedTodo);

      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = updatedTodo;
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTodo(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiService.deleteTodo(id);
      _todos.removeWhere((todo) => todo.id == id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }
}
