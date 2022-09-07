import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/screens/authenticate/authenticate.dart';
import 'package:summerapp/screens/home/sports.dart';
import 'package:summerapp/screens/home/userSignedIn.dart';
import 'package:summerapp/screens/wrapper.dart';
import 'package:summerapp/services/auth.dart';

import '../../models/controller.dart';
import '../../models/tile.dart';
import '../../models/user.dart';
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
    return user != null ? MyUser(uid: user.uid) : null;
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

    // final FirebaseAuth _auth = FirebaseAuth.instance;

    final user = Provider.of<MyUser?>(context);
    print(user);

    bool backButton = true;

    bool showBackButton() {
      String correctWord = Provider.of<Controller>(context, listen: false).getCorrectWord();
      print(correctWord);
      List<Tile> guessedWord = Provider.of<Controller>(context, listen: false).tilesEntered;
      print(guessedWord);
      List<String> guessed = [];
      String guessedWordString = "";
      int guessedWordIndex = guessedWord.length - 1;
      int letterCounter = 0;
      for(int i = correctWord.length - 1; i >= 0; i--) {
        if(correctWord[i] == guessedWord[guessedWordIndex].letter) {
          letterCounter++;
          guessedWordIndex--;
        }
      }
      if(letterCounter == correctWord.length && correctWord != "") {
        return false;
      }
      if(user == null) {
        return true;
      } else {
        return false;
      }

    }

    /*
    String correctWord = Provider.of<Controller>(context, listen: false).getCorrectWord();
    print(correctWord);
    List<Tile> guessedWord = Provider.of<Controller>(context, listen: false).tilesEntered;
    print(guessedWord);
    List<String> guessed = [];
    String guessedWordString = "";
    int guessedWordIndex = guessedWord.length - 1;
    int letterCounter = 0;
    for(int i = correctWord.length - 1; i >= 0; i--) {
      if(correctWord[i] == guessedWord[guessedWordIndex].letter) {
        letterCounter++;
        guessedWordIndex--;
      }
    }
    if(letterCounter == correctWord.length && correctWord != "") {
      if(user == null) {
        setState(() {
          backButton = true;
        });
      }
      setState(() {
        backButton = false;
      });
    }
     */


    MyUser test = MyUser();
    test.uid;

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
        // automaticallyImplyLeading: backButton,
        automaticallyImplyLeading: false,
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
            // label: Text("Logout"),
            label: Text(signedIn),
            onPressed: () async {
              if(signedIn == "Logout") {
                _auth.signOut();
              } else {
                Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => const Authenticate()),
                  MaterialPageRoute(builder: (context) => const Wrapper()),
                );
              }
              /*
              if(user == null) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Authenticate()),
                );
              }
              */
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
