import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFunc);
  final void Function(String email, String uname, String password, bool isLogin)
      submitFunc;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //_formKey is used to trigger the Form widget.
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  //Global variables to store the data from the form.
  var _userEmail = '';
  var _userName = '';
  var _userPass = '';

  void _trySubmit() {
    //.validate() runs all the validation classes at the same time.
    final isValid = _formKey.currentState?.validate();

    //used to close soft keyboard when we click submit.
    FocusScope.of(context).unfocus();
    if (isValid == true) {
      //.save() runs all the onSave classes in the form.
      _formKey.currentState?.save();
      widget.submitFunc(_userEmail, _userName, _userPass, _isLogin);
      print(_userEmail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                //Connecting the form with its key.
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value != null &&
                            (value.isEmpty || !value.contains('@'))) {
                          return 'Please enter a valid email id.';
                        }
                      },
                      onSaved: (val) {
                        if (val != null) _userEmail = val;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                    ),
                    //We only add username is we are not on login screen.
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value != null &&
                              (value.isEmpty || value.length < 4)) {
                            return 'username cannot be null';
                          }
                        },
                        onSaved: (val) {
                          if (val != null) _userName = val;
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                    TextFormField(
                      key: ValueKey('passsword'),
                      validator: (value) {
                        if (value != null &&
                            (value.isEmpty || value.length < 7)) {
                          return 'not valid';
                        }
                      },
                      onSaved: (val) {
                        if (val != null) _userPass = val;
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'SignUp'),
                      onPressed: _trySubmit,
                    ),
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          //WE CHANGE THE STATE ACCORDING TO LOGIN VARIABLE.
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child:
                            //We change the text according to isLogin.
                            Text(_isLogin ? "Crete a new account" : 'Login '))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
