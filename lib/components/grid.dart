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
  String puzzleWord;
  String gameMode;
  String category;
  _GridState(this.puzzleWord, this.gameMode, this.category);

  late String _word;
  final CollectionReference dataStore = FirebaseFirestore.instance.collection('DataStore');

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    print(screenHeight);

    String correctWord = Provider.of<Controller>(context, listen: false).getCorrectWord();
    print(correctWord);

    List<double> screenSizing() {
      List<double> LTRB = [];
      if(correctWord.length == 4) {

        LTRB.add(0.12820513 * screenWidth);
        LTRB.add(0.01184834 * screenHeight);
        LTRB.add(0.12820513 * screenWidth);
        LTRB.add(0.01184834 * screenHeight);
        /*
        LTRB.add(50);
        LTRB.add(10);
        LTRB.add(50);
        LTRB.add(10);
         */
      }
      if(correctWord.length == 5) {
        LTRB.add(0.07692308 * screenWidth);
        LTRB.add(0.01184834 * screenHeight);
        LTRB.add(0.07692308 * screenWidth);
        LTRB.add(0.01184834 * screenHeight);
        /*
        LTRB.add(30);
        LTRB.add(10);
        LTRB.add(30);
        LTRB.add(10);
         */
      }
      if(correctWord.length == 6) {
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.03554502 * screenHeight);
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.03554502 * screenHeight);
        /*
        LTRB.add(20);
        LTRB.add(30);
        LTRB.add(20);
        LTRB.add(30);
         */
      }
      if(correctWord.length == 7) {
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.07701422 * screenHeight);
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.07701422 * screenHeight);
        /*
        LTRB.add(20);
        LTRB.add(65);
        LTRB.add(20);
        LTRB.add(65);
         */
      }
      if(correctWord.length == 8) {
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.09478673 * screenHeight);
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.07701422 * screenHeight);
        /*
        LTRB.add(20);
        LTRB.add(80);
        LTRB.add(20);
        LTRB.add(65);
         */
      }
      if(correctWord.length == 9) {
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.09478673 * screenHeight);
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.07701422 * screenHeight);
        /*
        LTRB.add(20);
        LTRB.add(80);
        LTRB.add(20);
        LTRB.add(65);
         */
      }
      if(correctWord.length == 10) {
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.14218009 * screenHeight);
        LTRB.add(0.05128205 * screenWidth);
        LTRB.add(0.07701422 * screenHeight);
        /*
        LTRB.add(20);
        LTRB.add(120);
        LTRB.add(20);
        LTRB.add(65);
         */
      }
      return LTRB;
    }

    List<double> LTRB = screenSizing();

    return GridView.builder(
      // padding: EdgeInsets.fromLTRB(LTRB[0], LTRB[1], LTRB[2], LTRB[3]), // THIS IS WHAT KIND OF WORKS
      padding: EdgeInsets.fromLTRB(0.055 * screenWidth, 20, 0.055 * screenWidth, 50),
      itemCount: correctWord.length * 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        crossAxisCount: correctWord.length,
      ),
      itemBuilder: (context, index) {
        return GridTile(index: index,);
      },
    );
  }
}