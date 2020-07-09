import 'package:flutter/material.dart';
import 'package:flutter_crud/components/todo_tile.dart';
import 'package:flutter_crud/provider/todos.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Todos todos = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Todos'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.TODO_FORM);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todos.count,
        itemBuilder: (ctx, i) => TodoTile(
          todos.byIndex(i),
        ),
      ),
    );
  }
}
