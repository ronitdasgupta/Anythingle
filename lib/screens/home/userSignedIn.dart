import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:summerapp/screens/home/sports.dart';

import '../../services/auth.dart';
import 'geography.dart';

class UserSignedIn extends StatefulWidget {
  // const UserSignedIn({Key? key}) : super(key: key);
  final Function toggleView;
  UserSignedIn({required this.toggleView});


  @override
  _UserSignedInState createState() => _UserSignedInState();
}

class _UserSignedInState extends State<UserSignedIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // automaticallyImplyLeading: backButton,
        // automaticallyImplyLeading: false,
        /*
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Authenticate()),
            );
          },
        ),
        */
        title: const Text(
            "Modes"
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        actions: <Widget>[
          const IconButton(
            icon: Icon(Icons.account_box),
            onPressed: null,
          ),
          const IconButton(
            icon: Icon(Icons.leaderboard_outlined),
            onPressed: null,
          ),
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Logout"),
            onPressed: () async {
              /*
              if(user == null) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Authenticate()),
                );
              }
              */
              await _auth.signOut();
              widget.toggleView;
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Geography()),
                );
              },
              child: const Text(
                  "Geography"
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(280, 80),
                textStyle: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Sports()),
                );
              },
              child: const Text(
                  "Sports"
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(280, 80),
                textStyle: const TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text(
                  "Food"
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(280, 80),
                textStyle: const TextStyle(fontSize: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

