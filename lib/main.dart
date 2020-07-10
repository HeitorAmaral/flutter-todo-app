import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/todos.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/login_page.dart';
import 'package:flutter_crud/views/todo_form.dart';
import 'package:flutter_crud/views/todo_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Todos(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (_) => LoginPage(),
          AppRoutes.LOGIN_PAGE: (_) => TodoList(),
          AppRoutes.TODO_FORM: (_) => TodoForm()
        },
      ),
    );
  }
}
