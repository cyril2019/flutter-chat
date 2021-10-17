import 'package:chat_app/widget/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widget/auth_form.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  void _submitAuthForm(
      String email, String uname, String password, bool isLogin) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
