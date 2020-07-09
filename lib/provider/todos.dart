import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_todos.dart';
import 'package:flutter_crud/models/todo.dart';
import 'package:http/http.dart' as http;

class Todos with ChangeNotifier {
  static const _baseUrl = 'https://fir-todo-ba8db.firebaseio.com';
  final Map<String, Todo> _items = {...DUMMY_TODOS};

  List<Todo> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  Todo byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future<void> put(Todo todo) async {
    if (todo == null) {
      return;
    }

    if (todo.id != null &&
        todo.id.trim().isNotEmpty &&
        _items.containsKey(todo.id)) {
      await http.patch(
        "$_baseUrl/todos/${todo.id}.json",
        body: json.encode(
          {
            'description': todo.description,
            'iconUrl': todo.iconUrl,
          },
        ),
      );
      _items.update(
        todo.id,
        (_) => Todo(
          id: todo.id,
          description: todo.description,
          iconUrl: todo.iconUrl,
        ),
      );
    } else {
      final response = await http.post(
        "$_baseUrl/todos.json",
        body: json.encode(
          {
            'description': todo.description,
            'iconUrl': todo.iconUrl,
          },
        ),
      );

      final id = json.decode(response.body)['name'];

      _items.putIfAbsent(
        id,
        () => Todo(
          id: id,
          description: todo.description,
          iconUrl: todo.iconUrl,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> remove(Todo todo) async {
    if (todo != null && todo.id != null) {
      await http.delete(
        "$_baseUrl/todos/${todo.id}.json",
      );

      _items.remove(todo.id);
      notifyListeners();
    }
  }
}
