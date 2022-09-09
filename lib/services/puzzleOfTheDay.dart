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

  PuzzleOfTheDay(
      {
        required this.gameMode,
        required this.date,
      }
      );

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
    return "";
  }

}