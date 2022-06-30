import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/constant/words.dart';

import '../../../components/grid.dart';
import '../../../components/keyboardRow.dart';
import '../../../data/keysMap.dart';
import '../../../models/controller.dart';

class CountryPuzzle extends StatefulWidget {
  const CountryPuzzle({Key? key}) : super(key: key);

  @override
  _CountryPuzzleState createState() => _CountryPuzzleState();
}

class _CountryPuzzleState extends State<CountryPuzzle> {

  late String _word;
  @override
  void initState() {
    final r = Random().nextInt(words.length);
    _word = words[r];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false).setCorrectWord(word: _word);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text(
          "Country Puzzle",
        ),
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 2,
          ),
          const Expanded(
            flex: 7,
            child: Grid(),
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
  }
}
