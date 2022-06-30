import 'package:flutter/material.dart';
import 'package:summerapp/services/auth.dart';
import 'package:summerapp/shared/constants.dart';

import '../../shared/loading.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);

  final Function toggleView;
  SignIn({ required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text("Sign In"),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text(
              "Register",
            ),
            onPressed: () {
              widget.toggleView();
            }
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (String? value) {
                    if(value != null && value.isEmpty) {
                      return "Enter an email";
                    }
                    return null;
                  },
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                obscureText: true,
                  validator: (String? value) {
                    if(value != null && value.length < 6) {
                      return "Enter a password with more than 6 characters";
                    }
                    return null;
                  },
                onChanged: (val) {
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    color: Colors.white),
                  ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = "Invalid credentials";
                        loading = false;
                      });
                    }
                  }
                },
                ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
