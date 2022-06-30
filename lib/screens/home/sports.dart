import 'package:flutter/material.dart';

class Sports extends StatelessWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
            "Sports"
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

                },
                child: const Text(
                    "Soccer"
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
                    "Football"
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
                    "Basketball"
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
                    "Baseball"
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
