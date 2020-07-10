import 'package:flutter/material.dart';
import 'package:flutter_crud/routes/app_routes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is valid. Email: $_email Password: $_password');
      Navigator.of(context).pushNamed(AppRoutes.LOGIN_PAGE);
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: new InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Insira o seu e-mail...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'O e-mail deve ser preenchido!' : null,
                onSaved: (value) => _email = value,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Insira a sua senha...',
                ),
                validator: (value) =>
                    value.isEmpty ? 'A senha deve ser preenchida!' : null,
                onSaved: (value) => _password = value,
                obscureText: true,
              ),
              new RaisedButton(
                child: new Text(
                  'Entrar',
                  style: new TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    Navigator.of(context).pushNamed(AppRoutes.LOGIN_PAGE);
                  } else {
                    print('Form is invalid');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
