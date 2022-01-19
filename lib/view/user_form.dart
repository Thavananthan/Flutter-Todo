import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_app/models/user.dart';
import 'package:sqlite_app/provider/users.dart';

class UserForm extends StatelessWidget {
  final _from = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFromData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    } else {
      _formData['id'] = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      final user = args as User;
      _loadFromData(user);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('user from'),
          actions: [
            IconButton(
              onPressed: () {
                final isValid = _from.currentState?.validate();
                if (isValid!) {
                  _from.currentState?.save();
                  Provider.of<Users>(context, listen: false).put(User(
                      id: _formData['id'] != null ? _formData['id']! : '',
                      name: _formData['name']!,
                      email: _formData['email']!,
                      avatarUrl: _formData['avatarUrl']!));
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
                key: _from,
                child: Column(
                  children: [
                    Visibility(
                      visible: false,
                      child: TextFormField(
                        initialValue: _formData['id'],
                        onSaved: (value) => _formData['id'] = value!,
                      ),
                    ),
                    TextFormField(
                      initialValue: _formData['name'],
                      decoration: InputDecoration(labelText: "Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name requried';
                        }
                        if (value.trim().length < 3) {
                          return "Name letter : min 3 letter required";
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['name'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['email'],
                      decoration: InputDecoration(labelText: "Email"),
                      onSaved: (value) => _formData['email'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration: InputDecoration(labelText: "URL to avatar"),
                      onSaved: (value) => _formData['avatarUrl'] = value!,
                    )
                  ],
                ))));
  }
}
