import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/screens/authenticate/authenticate.dart';
import 'package:summerapp/screens/home/sports.dart';
import 'package:summerapp/screens/home/userSignedIn.dart';
import 'package:summerapp/screens/wrapper.dart';
import 'package:summerapp/services/auth.dart';

import '../../models/controller.dart';
import '../../models/dbPuzzles.dart';
import '../../models/puzzleInfo.dart';
import '../../models/tile.dart';
import '../../models/user.dart';
import '../../services/dataStoreCollection.dart';
import '../../services/puzzlesCollection.dart';
import 'geography.dart';
import 'guest.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final AuthService _auth = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid, emailVerified: user.emailVerified) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  bool guest = true;
  void toggleView() {
    setState(() => guest = !guest);
  }



  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print(user);

    String userSignedIn() {
      if(user?.uid == null || user?.uid == "") {
        return "Register";
      } else {
        return "Logout";
      }
    }

    setState(() {
      String signedIn = userSignedIn();
    });

    String signedIn = userSignedIn();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            label: Text(signedIn),
            onPressed: () async {
              if(signedIn == "Logout") {
                _auth.signOut();
                // await _auth.signOut();
              } else {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Wrapper()),
                );
              }
              await _auth.signOut();
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
              // onPressed: null,
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
                final snackBar = SnackBar(
                  backgroundColor: Colors.grey,
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(Icons.info, size: 32),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Coming soon!",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  duration: const Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                  "Food"
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
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
