import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/constant/words.dart';
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
  // String selectedDate = "Select Date";
  String dateSelected = DateFormat('yyyy-MM-dd').format(DateTime.now());





  // late final CountriesAPI countriesAPI;
  // Future<CountriesAPI> countriesAPI = getFromDB(gameMode);

  late String _word;
  // String _word = "";
  @override
  void initState() {
    super.initState();
    // PuzzleOfTheDay puzzleOfTheDay = PuzzleOfTheDay(gameMode: "Countries", date: "");
    // puzzleOfTheDay.puzzleFromDB();
    // puzzleOfTheDay.puzzleFromDBv2();
    // _word = puzzleOfTheDay.wordOfTheDay;
    // _word = puzzleOfTheDay.puzzleFromDB();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _word = puzzleOfTheDay.puzzleFromDB();
      // Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    });
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {

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

    final allDBPuzzles = Provider.of<List<DBPuzzles>>(context);
    print(allDBPuzzles);

    final allPuzzlesEachDate = Provider.of<List<PuzzleInfo>>(context);
    print(allPuzzlesEachDate);

    final allPuzzleInformationDB = Provider.of<List<PuzzleInformationDB>>(context);
    print(allPuzzleInformationDB);

    // counter++;



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
            // country = date.answer;
            print(country);
          });

          // return country;
        }
        /*
        else {
          counter++;
          allDBPuzzles.forEach((gameMode) {
            if(gameMode.gameMode == "Countries") {
              // List<String> countryList = gameMode.puzzleList;
              final rand = Random();
              country = gameMode.puzzleList[rand.nextInt(gameMode.puzzleList.length)];
              print(country);

              // Write the country into the Puzzles collection for the selected date
              PuzzleInfo newPuzzleInfo = PuzzleInfo(answer: country, date: dateSelected);
              GameMode newAnswer = GameMode(game: gameType, puzzleInfo: newPuzzleInfo);

              // Check if the collection already has a country in it
              if(allPuzzlesEachDate.isNotEmpty) {

              }
              updatePuzzleCollectionInFirestore(newAnswer);



              // _word = gameMode.puzzleList[rand.nextInt(gameMode.puzzleList.length)];
              // Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
              // print(_word);
            }
          });
          // return country;
        }
        */
      }
    }

    DateTime test = DateTime.now();
    // print(test);

    // String initDate = DateFormat('yyyy-MM-dd').format(test);
    DateTime firstDate = DateTime.parse("2022-08-08");





    /*
    allPuzzlesEachDate.forEach((date) {
      if(date.answer == "" || date.answer == null || allPuzzlesEachDate.isEmpty == true) {
        // The selected date is not in the collection
        allDBPuzzles.forEach((gameMode) {
          if(gameMode.gameMode == "Countries") {
            // List<String> countryList = gameMode.puzzleList;
            final rand = Random();
            String country = gameMode.puzzleList[rand.nextInt(gameMode.puzzleList.length)];
            // _word = gameMode.puzzleList[rand.nextInt(gameMode.puzzleList.length)];
            // Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
            // print(_word);
          }
        });
      } else {
        // The selected date is in the collection
        String country = date.answer;
        // _word = country;
      }
    });
     */

    /*
    allDBPuzzles.forEach((gameMode) {
      if(gameMode.gameMode == "Countries") {
        // List<String> countryList = gameMode.puzzleList;
        final rand = Random();
        _word = gameMode.puzzleList[rand.nextInt(gameMode.puzzleList.length)];
        // Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
        // print(_word);
      }
    });
     */

    // PuzzleOfTheDay puzzleOfTheDay = PuzzleOfTheDay(gameMode: "Countries", date: "");
    // _word = puzzleOfTheDay.puzzleFromDB();
    // _word = "INDIA";
    // _word = getCountry();

    // _word = "INDIA";
    /*
    if(counter > 1) {
      // _word = getCountry();
      _word = country;
    }
     */

    if(allDBPuzzles.isNotEmpty) {
      _word = country;
      _word = _word.toUpperCase();
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    }

    Future pickDate(BuildContext context) async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.parse("2022-08-08"),
        lastDate: DateTime.now(),
      );
      if(newDate == null) {
        return;
      }
      setState(() {
        _dateTime = newDate;
      });

      // final initialDate =     DateTime firstDate = DateTime.parse("2022-07-07");
    }

    DateTime dateSelectedFormat = DateTime.parse(dateSelected);

    return StreamProvider<List<PuzzleInfo>>.value(
      // value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInformation,
      value: PuzzlesCollection(gameMode: gameMode, dateSelected: currentDate).puzzleInfo,
      // value: PuzzlesCollection(gameMode: gameMode, dateSelected: "test").puzzleInfo,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Country",
          ),
          // automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[700],
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
                    // initialDate: _dateTime! == null ? DateTime.now() : _dateTime!, THIS CODE KIND OF WORKS
                    initialDate: _dateTime ?? dateSelectedFormat,
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


                      // Countries(); // Might need this piece of code in the future
                      // CountryPuzzle();
                      // dateSelected = _dateTime;
                      /*
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Countries()),
                      );
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Grid(puzzleWord: _word, gameMode: "Countries", category: "Geography")),
                      );
                       */
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
            /*
            TextButton.icon(
              icon: const Icon(Icons.exit_to_app),
              label: const Text(
                "Quit",
              ), onPressed: () {
                exit(0);
            },
            ),
            */
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


    /*
    return Scaffold(
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
    );
    */
  }
}