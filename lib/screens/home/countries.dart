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
