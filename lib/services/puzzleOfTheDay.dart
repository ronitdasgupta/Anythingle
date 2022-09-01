import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:summerapp/services/puzzlesCollection.dart';

import '../models/dbPuzzles.dart';
import '../models/puzzleInfo.dart';

class PuzzleOfTheDay {
  String gameMode;
  String date;
  String wordOfTheDay = "";
  // final CollectionReference dataStore = FirebaseFirestore.instance.collection('DataStore');

  PuzzleOfTheDay(
      {
        required this.gameMode,
        required this.date,
      }
      );

  /*
  String puzzleFromDB() {
    // Read puzzles collection for date

    // if the date passed is in puzzles collection then read from puzzles collection
    // else read datastore collection for specific game mode and get random from word
    String puzzleWord = readExistingPuzzlesCollection();
    if(puzzleWord == "") {
      return readExistingDataStoreCollection();
    }
    // return "";
    return puzzleWord;
  }
   */

  /*
  void puzzleFromDBv2() {
    String puzzleWord = readExistingPuzzlesCollection();
    if(puzzleWord == "") {
      // readDataStoreCollection();
    }
  }
   */

  /*
  String readExistingPuzzlesCollection() {
    // THE DATE SHOULD BE PASSED BASED ON THE DATE WHICH THE USER IS ON

    // Check if date is present in puzzle collection documents
    // If date is found, find the game mode and return the answer
    // String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String currentDate = "2022-07-07";
    FirebaseFirestore.instance.collection('Puzzles').doc(currentDate).get().then((DocumentSnapshot documentSnapshot) {
      if(documentSnapshot.exists) {
        var temp = documentSnapshot.data() as Map<String, dynamic>;
        String puzzleAnswer = temp['country']['answer'];
        print(puzzleAnswer);
        return puzzleAnswer;
      } else {
        return "";
        print('Document Does Not Exist on the Database');
      }
    });
    return "";
  }
   */

  String randomPuzzleAnswer(DBPuzzles dbPuzzles) {
    final rand = Random();
    String randPuzzleAnswer = dbPuzzles.puzzleList[rand.nextInt(dbPuzzles.puzzleList.length)];
    return randPuzzleAnswer;
  }

  Future<void> updatePuzzleCollectionInFirestore(GameMode gameMode) async {
    final PuzzlesCollection puzzlesCollection = PuzzlesCollection(gameMode: "country", dateSelected: '2022-07-08');
    // dynamic result = await puzzlesCollection.updatePuzzleCollection(gameMode, "country");
    dynamic result = await puzzlesCollection.testUpdatePuzzleCollection(gameMode, "country", 'this does not work');
    if(result == null) {
      print("error in updatePuzzleCollectionInFirestore");
    }
  }

  void writeToPuzzlesCollection(String puzzleWord) {
    PuzzleInfo newPuzzleInfo = PuzzleInfo(answer: puzzleWord, date: "");
    GameMode newAnswer = GameMode(game: gameMode, puzzleInfo: newPuzzleInfo);
    updatePuzzleCollectionInFirestore(newAnswer);
  }

  /*
  Future<void> readDataStoreCollection() async {
    List<String> puzzleAnswers = [];
    DBPuzzles dbPuzzles = DBPuzzles(puzzleList: []);
    await FirebaseFirestore.instance.collection('DataStore').doc(gameMode).get()(DocumentSnapshot documentSnapshot) {
      // The snapshot should always exist
      if(documentSnapshot.exists) {
        var temp = documentSnapshot.data() as Map<String, dynamic>;
        puzzleAnswers = List<String>.from(temp['puzzleList'] as List);
        dbPuzzles = DBPuzzles(puzzleList: puzzleAnswers);
        wordOfTheDay = randomPuzzleAnswer(dbPuzzles);
        writeToPuzzlesCollection(wordOfTheDay);
        print(wordOfTheDay);
      } else {
      }
    });
    // return randomPuzzleAnswer(dbPuzzles);
  }
   */


  String readExistingDataStoreCollection() {
    // Find the document that corresponds with the game mode
    // Read the list of puzzle answers and generate a random word
    // Read documents from Firestore collection
    List<String> puzzleAnswers = [];
    DBPuzzles dbPuzzles = DBPuzzles(puzzleList: [], gameMode: "");
    FirebaseFirestore.instance.collection('DataStore').doc(gameMode).get().then((DocumentSnapshot documentSnapshot) {
      // The snapshot should always exist
      if(documentSnapshot.exists) {
        var temp = documentSnapshot.data() as Map<String, dynamic>;
        puzzleAnswers = List<String>.from(temp['puzzleList'] as List);
        dbPuzzles = DBPuzzles(puzzleList: puzzleAnswers, gameMode: gameMode);
        String randomPuzzle = randomPuzzleAnswer(dbPuzzles);
        writeToPuzzlesCollection(randomPuzzle);
        print(randomPuzzle);
        return randomPuzzleAnswer(dbPuzzles);
      } else {
        return "";
      }
    });
    // return randomPuzzleAnswer(dbPuzzles);
    return "";
  }

}