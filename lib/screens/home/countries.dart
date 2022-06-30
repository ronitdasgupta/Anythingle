import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/screens/home/puzzles/countryPuzzle.dart';
import 'package:summerapp/services/puzzlesCollection.dart';

import '../../models/puzzleInfo.dart';

class Countries extends StatefulWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  State<Countries> createState() => _CountriesState();
}



class _CountriesState extends State<Countries> {

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String gameMode = "country";
  String puzzleAnswer = "";
  final CollectionReference puzzles = FirebaseFirestore.instance.collection('Puzzles');

  Future<void> updatePuzzleCollectionInFirestore(GameMode gameMode) async {
    final PuzzlesCollection puzzlesCollection = PuzzlesCollection();
    // dynamic result = await puzzlesCollection.updatePuzzleCollection(gameMode, "country");
    dynamic result = await puzzlesCollection.testUpdatePuzzleCollection(gameMode, "country");
    if(result == null) {
      setState(() {
        // print('error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    List<dynamic> puzzleArray = [];

    /*
    try {
      final allPuzzles = Provider.of<List<PuzzleInfo>>(context, listen: false);
      allPuzzles.forEach((mode) {
        dynamic dates = {'answer': '', 'date': ''};
        puzzleArray.add(dates);
      });
      // PuzzleInfo testing = PuzzleInfo(dates: puzzleArray, gameMode: gameMode);
      // updatePuzzleCollectionInFirestore(testing);
    } catch(e) {
      print(e.toString());
    }
     */


    void addCountry() async {
      var response = await http.get(Uri.https('restcountries.com', 'v3.1/all'));
      var jsonData = jsonDecode(response.body);
      List<String> currentCountries = [];
      for(var u in jsonData) {
        Country country = Country(u['name']['common']);
        if(country.common.length < 11 && !country.common.contains(" ") && country.common != "CuraÃ§ao" && country.common != "RÃ©union") {
          currentCountries.add(country.common);
        }
      }
      print(currentCountries);
      print(currentCountries.length);

      int counter = 0;
      await for(var snapshot in puzzles.snapshots()) {
        for(var document in snapshot.docs) {
          if(document.id == currentDate) {
            // print(document[gameMode]);
            puzzleAnswer = document['country']['answer'];
            break;
            // print(puzzleAnswer);
            // print(document['country']);
          } else {
            counter++;
          }
        }
        if(counter != 0) {
          // The date is not in the Puzzles Collection
          final rand = new Random();
          var randCountry = currentCountries[rand.nextInt(currentCountries.length)];
          PuzzleInfo newPuzzleInfo = PuzzleInfo(answer: randCountry);
          GameMode newAnswer = GameMode(game: gameMode, puzzleInfo: newPuzzleInfo);
          updatePuzzleCollectionInFirestore(newAnswer);
        }
      }
      /*
      if(counter != 0) {
        // The date is not in the Puzzles Collection
        final rand = new Random();
        var randCountry = currentCountries[rand.nextInt(currentCountries.length)];
        PuzzleInfo newPuzzleInfo = PuzzleInfo(answer: randCountry);
        updatePuzzleCollectionInFirestore(newPuzzleInfo);
      }
       */
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text(
            "Countries"
        ),
      ),
      body: Center(
        child: ElevatedButton(
            child: Text(
                "Click Me"
            ),
            onPressed: () {
              // addCountry();
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CountryPuzzle()),
              );
            }
        ),
      ),
    );
  }
}

class Country{
  final String common;
  Country(this.common);

  @override
  String toString() {
    return '${common}';
  }
}
