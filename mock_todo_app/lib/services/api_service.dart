import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/todo_model.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  final http.Client _client = http.Client();

  Future<List<Todo>> getTodos() async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/todos'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Todo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load todos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching todos: $e');
    }
  }

  Future<Todo> getTodo(int id) async {
    try {
      final response = await _client.get(Uri.parse('$baseUrl/todos/$id'));

      if (response.statusCode == 200) {
        return Todo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching todo: $e');
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/todos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 201) {
        return Todo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating todo: $e');
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/todos/${todo.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 200) {
        return Todo.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating todo: $e');
    }
  }

  Future<void> deleteTodo(int id) async {
    try {
      final response = await _client.delete(Uri.parse('$baseUrl/todos/$id'));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting todo: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
