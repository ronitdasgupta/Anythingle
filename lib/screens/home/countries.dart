import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/dbPuzzles.dart';
import 'package:summerapp/screens/home/puzzles/countryPuzzle.dart';
import 'package:summerapp/services/puzzlesCollection.dart';

import '../../models/puzzleInfo.dart';
import '../../services/dataStoreCollection.dart';

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
    final PuzzlesCollection puzzlesCollection = PuzzlesCollection(gameMode: "country", dateSelected: currentDate);
    // dynamic result = await puzzlesCollection.updatePuzzleCollection(gameMode, "country");
    dynamic result = await puzzlesCollection.testUpdatePuzzleCollection(gameMode, "country", currentDate);
    if(result == null) {
      setState(() {
        // print('error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    /*
    final allDBPuzzles = Provider.of<List<DBPuzzles>>(context);
    print(allDBPuzzles);

    allDBPuzzles.forEach((gameMode) {
      if(gameMode.gameMode == "Countries") {
        // List<String> countryList = gameMode.puzzleList;
        final rand = Random();
        String country = gameMode.puzzleList[rand.nextInt(gameMode.puzzleList.length)];
        print(country);
      }
    });
     */

    /*
      return StreamProvider<List<PuzzleInformationDB>>.value(
        value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInformation,
        initialData: [],
        child: const Scaffold(
          backgroundColor: Colors.black,
          body: CountryPuzzle(),
        ),
      );
     */

    /*
    return StreamProvider<List<PuzzleInformationDB>>.value(
      value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInformation,
      initialData: [],
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: CountryPuzzle(),
      ),
    );
     */



    return StreamProvider<List<PuzzleInfo>>.value(
      // value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInformation,
      // value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInfo,
      // value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInfo, // THIS IS WHERE THE ISSUE IS
      value: PuzzlesCollection(gameMode: gameMode).puzzleInfo,
      initialData: [],
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: CountryPuzzle(),
      ),
    );

    /*
    return const Scaffold(
      backgroundColor: Colors.black,
      body: CountryPuzzle(),
    );
     */


    /*
    return StreamProvider<List<PuzzleInfo>>.value(
      // value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInformation,
      // value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInfo,
      value: PuzzlesCollection(gameMode: gameMode, dateSelected: selectedDate).puzzleInfo, // THIS IS WHERE THE ISSUE IS
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[700],
          title: const Text(
            "Country Puzzle",
          ),
          actions: <Widget>[
            TextButton.icon(
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  // "Select Date",
                  dateSelected,
                ),
                onPressed: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    // initialDate: DateTime.now(),
                    // initialDate: DateTime.now(),
                    initialDate: _dateTime! == null ? DateTime.now() : _dateTime!,
                    // initialDate: _dateTime == DateTime.now() : _dateTime,
                    // initialDate: initDate,
                    // firstDate: DateTime(2021),
                    firstDate: firstDate,
                    // firstDate: DateTime.
                    lastDate: DateTime.now(),
                  ).then((date) {
                    setState(() {
                      _dateTime = date;
                      dateSelected = DateFormat('yyyy-MM-dd').format(_dateTime!);
                      // dateSelected = _dateTime;
                      print(_dateTime);
                    });
                  });
                }),
          ],
        ),
        body: Column(
          children: [
            const Divider(
              height: 1,
              thickness: 2,
            ),
            Expanded(
              flex: 7,
              child: Grid(puzzleWord: _word, gameMode: "Countries", category: "Geography"),
            ),
            Expanded(
                flex: 4,
                child: Column(
                  children: const [
                    KeyboardRow(min: 1, max: 10),
                    KeyboardRow(min: 11, max: 19),
                    KeyboardRow(min: 20, max: 29),
                  ],
                )
            ),
          ],
        ),
      ),
    );
    */





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
