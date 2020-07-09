import 'package:flutter/material.dart';
import 'package:flutter_crud/models/todo.dart';
import 'package:flutter_crud/provider/todos.dart';
import 'package:provider/provider.dart';

class TodoForm extends StatefulWidget {
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _formData = {};

  void _loadFormData(Todo todo) {
    if (todo != null) {
      _formData['id'] = todo.id;
      _formData['description'] = todo.description;
      _formData['iconUrl'] = todo.iconUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Todo todo = ModalRoute.of(context).settings.arguments;
    _loadFormData(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Tarefa"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () async {
              final isValid = _form.currentState.validate();
              if (isValid) {
                _form.currentState.save();
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Todos>(context, listen: false).put(
                  Todo(
                    id: _formData['id'],
                    description: _formData['description'],
                    iconUrl: _formData['iconUrl'],
                  ),
                );
                setState(() {
                  _isLoading = false;
                });
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _formData['description'],
                      decoration: InputDecoration(labelText: 'Descrição'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'É necessário preencher o campo Descrição para salvar!';
                        }
                        if (value.trim().length < 3) {
                          return 'Campo Descrição muito pequeno. No mínimo 3 letras!';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['description'] = value,
                    ),
                    TextFormField(
                      initialValue: _formData['iconUrl'],
                      decoration: InputDecoration(labelText: 'URL do ícone'),
                      onSaved: (value) => _formData['iconUrl'] = value,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
