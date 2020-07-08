import 'package:flutter/material.dart';
import 'package:flutter_crud/models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile(this.todo);

  @override
  Widget build(BuildContext context) {
    final icon = todo.iconUrl == null || todo.iconUrl.isEmpty
        ? CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(todo.iconUrl),
          );
    return ListTile(
      leading: icon,
      title: Text(todo.description),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: new Icon(Icons.edit),
                color: Colors.orange,
                onPressed: () {}),
            IconButton(
                icon: new Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
