import 'package:flutter/material.dart';
import 'package:summerapp/screens/home/sports.dart';
import 'package:summerapp/services/auth.dart';

import 'geography.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
            "Game Modes"
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
