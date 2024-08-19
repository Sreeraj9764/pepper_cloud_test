import 'dart:convert';

import 'package:pepper_cloud_test/core/app_core.dart';
import 'package:pepper_cloud_test/features/todo/data/models/todo_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class TodoLocalDataSource {
  Future<void> deleteTodo(String id);
  Stream<List<TodoModel>> getTodos();
  Future<void> saveTodo(TodoModel todoModel);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  TodoLocalDataSourceImpl({required SharedPreferences prefs}) : _prefs = prefs {
    _init();
  }

  final SharedPreferences _prefs;

  late final _todoStreamController =
      BehaviorSubject<List<TodoModel>>.seeded(const []);

  void _init() {
    final todosJson = _prefs.getString(AppStrings.kTodosCollectionKey);
    if (todosJson != null) {
      final todos = List<Map<dynamic, dynamic>>.from(
        json.decode(todosJson) as List,
      )
          .map((jsonMap) =>
              TodoModel.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _todoStreamController.add(todos);
    } else {
      _todoStreamController.add(const []);
    }
  }

  @override
  Future<void> deleteTodo(String id) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == id);
    if (todoIndex == -1) {
      throw const ClientException(message: "Todo not found");
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return _prefs.setString(
          AppStrings.kTodosCollectionKey, json.encode(todos));
    }
  }

  @override
  Stream<List<TodoModel>> getTodos() =>
      _todoStreamController.asBroadcastStream();

  @override
  Future<void> saveTodo(TodoModel todoModel) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((t) => t.id == todoModel.id);
    if (todoIndex >= 0) {
      todos[todoIndex] = todoModel;
    } else {
      todos.add(todoModel);
    }

    _todoStreamController.add(todos);
    return _prefs.setString(AppStrings.kTodosCollectionKey, json.encode(todos));
  }
}
