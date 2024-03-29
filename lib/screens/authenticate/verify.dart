import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/screens/authenticate/authenticate.dart';
import 'package:summerapp/screens/home/home.dart';
import 'package:summerapp/screens/wrapper.dart';

import '../../models/user.dart';
import '../custom_wrapper.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {


  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Verification"),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.exit_to_app),
            label: const Text(
              ""
            ),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CustomWrapper()),
              );
            }
          ),
        ],
      ),
      body: Center(
        child: Text("An email has been sent to ${user.email} please verify to continue."),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    await user.reload();
    if(user.emailVerified) {
      timer.cancel();
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Wrapper()));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const CustomWrapper()));
    }
  }
}
