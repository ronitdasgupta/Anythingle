import 'package:flutter/material.dart';
import 'package:summerapp/shared/constants.dart';

import '../../models/countryInfo.dart';
import '../../services/auth.dart';
import '../../shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ required this.toggleView });

  // const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String username = "";
  String error = "";
  late CountryInfo countryInfo;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[700],
        title: const Text("Sign Up"),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(Icons.person),
              label: const Text(
                "Sign In",
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
                  decoration: textInputDecoration.copyWith(hintText: "Username"),
                validator: (String? value) {
                  if(value != null && value.isEmpty) {
                    return "Enter a username";
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => username = val);
                }
              ),
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
                  "Register",
                  style: TextStyle(
                      color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password, username);

                    /*
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password, username).then((_) {
                    });
                     */
                    if(result == null) {
                      setState(() {
                        error = "Please enter a valid email";
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
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
