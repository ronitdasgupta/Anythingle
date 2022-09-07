import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/dbPuzzles.dart';
import 'package:summerapp/screens/home/puzzles/countryPuzzle.dart';
import 'package:summerapp/services/dataStoreCollection.dart';

import 'countries.dart';

class Geography extends StatelessWidget {
  const Geography({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<DBPuzzles>>.value(
      value: DataStoreCollection().dbPuzzles,
      initialData: [],
      child: Scaffold(
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
                      // MaterialPageRoute(builder: (context) => const CountryPuzzle()),
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
                      "Country Capitals"
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
                      "States"
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
                      "State Capitals"
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
      ),
    );
  }
}
