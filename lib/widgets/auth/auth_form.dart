import 'dart:io';

import 'package:flutter/material.dart';

import '../../widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Future<void> Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext context,
  ) onSubmit;
  final bool isLoading;

  AuthForm(this.onSubmit, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail;
  String _userName;
  String _userPassword;
  File _userImage;

  void _submit() {
    final bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (!_isLogin && _userImage == null) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please pick and image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.onSubmit(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName != null ? _userName.trim() : null,
        _isLogin,
        context,
      );
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String _validateUsername(String value) {
    if (value.isEmpty || value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    return null;
  }

  String _validatePassword(String value) {
    if (value.isEmpty || value.length < 7) {
      return 'Password must be at least 7 characters long';
    }
    return null;
  }

  void _pickImage(File pickedImage) {
    _userImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin) UserImagePicker(_pickImage),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email address'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: _validateUsername,
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: _validatePassword,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _submit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
