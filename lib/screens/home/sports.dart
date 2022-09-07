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
                    "Soccer"
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  minimumSize: const Size(280, 80),
                  textStyle: const TextStyle(fontSize: 28),
                )
            ),
            const SizedBox(height: 20.0),
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
                    "Football"
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  minimumSize: const Size(280, 80),
                  textStyle: const TextStyle(fontSize: 28),
                )
            ),
            const SizedBox(height: 20.0),
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
                    "Basketball"
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  minimumSize: const Size(280, 80),
                  textStyle: const TextStyle(fontSize: 28),
                )
            ),
            const SizedBox(height: 20.0),
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
                    "Baseball"
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
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
