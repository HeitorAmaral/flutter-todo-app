import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_todos.dart';
import 'package:flutter_crud/models/todo.dart';

class Todos with ChangeNotifier {
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

  void put(Todo todo) {
    if (todo == null) {
      return;
    }

    if (todo.id != null &&
        todo.id.trim().isNotEmpty &&
        _items.containsKey(todo.id)) {
      _items.update(
        todo.id,
        (_) => Todo(
          id: todo.id,
          description: todo.description,
          iconUrl: todo.iconUrl,
        ),
      );
    } else {
      final id = Random().nextDouble().toString();
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

  void remove(Todo todo) {
    if (todo != null && todo.id != null) {
      _items.remove(todo.id);
      notifyListeners();
    }
  }
}
