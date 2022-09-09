import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/screens/authenticate/register.dart';
import 'package:summerapp/screens/authenticate/sign_in.dart';

import '../../models/user.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);
  // String authenticationStatus;

  // Authenticate({required this.authenticationStatus});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn) {
      return Register(toggleView: toggleView);
    } else {
      return SignIn(toggleView: toggleView);
    }
  }
}
