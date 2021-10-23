import 'package:chat_app/widget/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widget/auth_form.dart';
import 'package:flutter/services.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  //Initializing an instance to firebaseAuth and Firestore.
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  var _isLoading = false;

  //This function will be used to send/recieve data from firebase Auth.
  void _submitAuthForm(String email, String uname, String password,
      bool isLogin, BuildContext context) async {
    UserCredential userCredential;
    try {
      if (isLogin) {
        //signInWith... function returns a Future of type UserCredentials.
        //So we store the userCredential in our variable
        //#Future : is a variable that can return a value or an error in future.
        //We use await to wait for the function to return userCredentials.
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _db
            .collection('users')
            .doc(userCredential.user?.uid.toString())
            .set({'uname': uname});
      }
    } on PlatformException catch (err) {
      final msg = err.message.toString();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
