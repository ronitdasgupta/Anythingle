import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/puzzleAnswers.dart';
import 'package:summerapp/screens/home/puzzles/countryPuzzle.dart';

import '../models/controller.dart';
import '../models/dbPuzzles.dart';
import '../screens/home/countries.dart';
import 'gridTile.dart';
import 'package:http/http.dart' as http;

class Grid extends StatefulWidget {
  String puzzleWord;
  String gameMode;
  String category;
  Grid({
    Key? key, required this.puzzleWord, required this.gameMode, required this.category,
  }) : super(key: key);

  @override
  State<Grid> createState() {
    return _GridState(this.puzzleWord, this.gameMode, this.category);
    // return _GridState();
  }
}

class _GridState extends State<Grid> {
  /*
  late final String puzzleWord;
  late final String gameMode;
  late final String category;
   */
  String puzzleWord;
  String gameMode;
  String category;
  _GridState(this.puzzleWord, this.gameMode, this.category);

  late String _word;
  final CollectionReference dataStore = FirebaseFirestore.instance.collection('DataStore');
  // late PuzzleAnswers puzzleAnswers;
  // late var puzzleAnswers = PuzzleAnswers();


  @override
  Widget build(BuildContext context) {

    String correctWord = Provider.of<Controller>(context, listen: false).getCorrectWord();
    print(correctWord);

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
      // itemCount: 30,
      // itemCount: puzzleWord.length * 6, THIS IS WHAT I USED TO HAVE THAT KIND OF WORKS
      itemCount: correctWord.length * 6,
      // itemCount: puzzleAnswers.country?.length * 6 ?? 30,
      // itemCount: nullCheckItemCount() as int,
      // itemCount: randCountry * 6,
      //vitemCount: randCountry.length * 6,
      // itemCount: randCountry.length * 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        // crossAxisCount: country.length,
        // crossAxisCount: puzzleWord.length, THIS IS WHAT I USED TO HAVE THAT KIND OF WORKS
        crossAxisCount: correctWord.length,
        // crossAxisCount: 5,
        // crossAxisCount: nullCheckCrossAxisCount() as int,
        // crossAxisCount: puzzleAnswers.country.length,
        // crossAxisCount: randCountry.length,
      ),
      itemBuilder: (context, index) {
        return GridTile(index: index,);
      },
    );
  }

  /*
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
        // itemCount: 30,
        itemCount: puzzleWord.length * 6,
        // itemCount: puzzleAnswers.country?.length * 6 ?? 30,
        // itemCount: nullCheckItemCount() as int,
        // itemCount: randCountry * 6,
        //vitemCount: randCountry.length * 6,
        // itemCount: randCountry.length * 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          // crossAxisCount: country.length,
          crossAxisCount: puzzleWord.length,
          // crossAxisCount: 5,
          // crossAxisCount: nullCheckCrossAxisCount() as int,
          // crossAxisCount: puzzleAnswers.country.length,
          // crossAxisCount: randCountry.length,
        ),
        itemBuilder: (context, index) {
          return GridTile(index: index,);
        },
      );
    });
  }

  WidgetsBinding.instance.addPostFrameCallback((_)){

  }
   */
}