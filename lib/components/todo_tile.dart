import 'package:flutter/material.dart';
import 'package:flutter_crud/models/todo.dart';
import 'package:flutter_crud/provider/todos.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

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
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.TODO_FORM,
                  arguments: todo,
                );
              },
            ),
            IconButton(
              icon: new Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Tarefa'),
                    content: Text(
                        'Tem certeza que deseja excluir permanentemente a tarefa?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then(
                  (confirmed) {
                    if (confirmed) {
                      Provider.of<Todos>(
                        context,
                        listen: false,
                      ).remove(todo);
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
