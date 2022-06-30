import 'package:flutter/material.dart';

import 'countries.dart';

class Geography extends StatelessWidget {
  const Geography({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
            "Geography"
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Countries()),
                  );
                },
                child: const Text(
                    "Countries"
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 80),
                  textStyle: const TextStyle(fontSize: 28),
                )
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                },
                child: const Text(
                    "Country Capitals"
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 80),
                  textStyle: const TextStyle(fontSize: 28),
                )
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {

                },
                child: const Text(
                    "States"
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 80),
                  textStyle: const TextStyle(fontSize: 28),
                )
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {

                },
                child: const Text(
                    "State Capitals"
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 80),
                  textStyle: const TextStyle(fontSize: 28),
                )
            ),
          ],
        ),
      ),
    );
  }
}
