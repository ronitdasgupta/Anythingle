import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/puzzleInfo.dart';
import 'package:summerapp/screens/home/help.dart';
import 'package:summerapp/services/puzzleOfTheDay.dart';
import 'package:summerapp/services/puzzlesCollection.dart';

import '../../../components/grid.dart';
import '../../../components/keyboardRow.dart';
import '../../../data/keysMap.dart';
import '../../../models/controller.dart';
import 'package:http/http.dart' as http;

import '../../../models/dbPuzzles.dart';
import '../../../models/puzzleAnswers.dart';
import '../countries.dart';

class CountryPuzzle extends StatefulWidget {
  const CountryPuzzle({Key? key}) : super(key: key);

  @override
  _CountryPuzzleState createState() => _CountryPuzzleState();
}

class _CountryPuzzleState extends State<CountryPuzzle> {

  final CollectionReference dataStore = FirebaseFirestore.instance.collection('DataStore');
  String gameType = "Countries";
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isChanged = true;
  String dateSelected = DateFormat('yyyy-MM-dd').format(DateTime.now());

  bool loading = false;

  late String _word;
  // String _word = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _word = "%%%%%";

    Provider.of<Controller>(context, listen: false).clearGrid();

    String country = "";
    int counter = 0;
    String gameMode = "country";
    // DateTime? _dateTime;
    DateTime? _dateTime = DateTime.now();
    DateTime temp = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String displayDate = formatter.format(temp);

    Future<void> updatePuzzleCollectionInFirestore(GameMode gameMode) async {
      final PuzzlesCollection puzzlesCollection = PuzzlesCollection(gameMode: gameType, dateSelected: currentDate);
      dynamic result = await puzzlesCollection.testUpdatePuzzleCollection(gameMode, "country", dateSelected);
      if(result == null) {
        print("error in updatePuzzleCollectionInFirestore");
      }
    }

    int allPuzzleEachDateCounter = 0;

    final allDBPuzzles = Provider.of<List<DBPuzzles>>(context);
    print(allDBPuzzles);

    final allPuzzlesEachDate = Provider.of<List<PuzzleInfo>>(context);
    print(allPuzzlesEachDate);

    final allPuzzleInformationDB = Provider.of<List<PuzzleInformationDB>>(context);
    print(allPuzzleInformationDB);

    // Read the puzzles collection to see if the selected date is in the collection
    if(allDBPuzzles.isNotEmpty && allPuzzlesEachDate.isNotEmpty) {
      if(allDBPuzzles.isNotEmpty) {
        if(allPuzzlesEachDate.isNotEmpty) {
          int countryCounter = 0;
          allPuzzlesEachDate.forEach((date) {
            if(date.date == dateSelected) {
              country = date.answer;
            } else {
              countryCounter++;
            }
            // Otherwise I need to write a random country for that day
            if(countryCounter == allPuzzlesEachDate.length) {
              allDBPuzzles.forEach((gameMode) {
                if(gameMode.gameMode == "Countries") {
                  final rand = Random();
                  country = gameMode.puzzleList[rand.nextInt(gameMode.puzzleList.length)];
                  // Write the country into the Puzzles collection for the selected date
                  PuzzleInfo newPuzzleInfo = PuzzleInfo(answer: country, date: dateSelected);
                  GameMode newAnswer = GameMode(game: gameType, puzzleInfo: newPuzzleInfo);

                  // Check if the collection already has a country in it
                  if(allPuzzlesEachDate.isNotEmpty) {

                  }
                  updatePuzzleCollectionInFirestore(newAnswer);
                }
              });
            }
            print(country);
          });
        }
      }
    }

    DateTime firstDate = DateTime.parse("2022-08-08");

    if(allDBPuzzles.isNotEmpty && allPuzzlesEachDate.isNotEmpty) {
      _word = country;
      _word = _word.toUpperCase();
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    } else {
      // _word = "TEST";
      // Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    }

    DateTime dateSelectedFormat = DateTime.parse(dateSelected);

    return StreamProvider<List<PuzzleInfo>>.value(
      value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInfo,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Country",
          ),
          backgroundColor: Colors.grey[700],
          actions: <Widget>[
            TextButton.icon(
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  dateSelected,
                ),
                onPressed: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _dateTime ?? dateSelectedFormat,
                    firstDate: firstDate,
                    lastDate: DateTime.now(),
                  ).then((date) {
                    setState(() {
                      _dateTime = date;
                      dateSelected = DateFormat('yyyy-MM-dd').format(_dateTime!);
                      Provider.of<Controller>(context, listen: false).clearGrid();
                      // Grid(puzzleWord: _word, gameMode: "Countries", category: "Geography");
                      // Read through the provider and find the country associated with the selected date and make it the _word
                      allPuzzlesEachDate.forEach((date) {
                        if(date.date == dateSelected) {
                          _word = date.answer;
                          final gridObject = Grid(puzzleWord: _word, gameMode: "Countries", category: "Geography");
                          Grid(puzzleWord: gridObject.puzzleWord, gameMode: gridObject.gameMode, category: gridObject.category);
                        }
                      });
                      print(_dateTime);
                    });
                  });
                }),
            TextButton.icon(
              icon: const Icon(Icons.help),
              label: const Text(""),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Help()),
                );
              }
            ),
          ],
        ),
        body: Column(
          children: [
            /*
            Text(
              "Country",
            ),
            */
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
  }
}