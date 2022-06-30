import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:summerapp/models/tile.dart';

import '../constant/answerStages.dart';
import '../data/keysMap.dart';

class Controller extends ChangeNotifier {

  String correctWord = "";
  int currentTile = 0, currentRow = 0;
  List<Tile> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({ required String value}) {
    if(value == 'ENTER') {
      if(currentTile == 5 * (currentRow + 1)) {
        // currentRow++;
        checkWord();
        print('check word');
      }
    } else if(value == 'BACK') {
      if(currentTile > 5 * (currentRow + 1) - 5) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      if(currentTile < 5 * (currentRow + 1)) {
        tilesEntered.add(Tile(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
    // print('current tile $currentTile and currentRow $currentRow');
  }

  checkWord() {
    List<String> guessed = [], remainingCorrect = [];;
    String guessedWord = "";
    for(int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessed.add(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();
    if(guessedWord == correctWord) {
      for(int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
      // print('word guessed correct!');
    } else {
      for(int i = 0; i < 5; i++) {
        if(guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
          // Letter guessed at the correct spot
          // print('letter guessed at ${guessedWord[i]}');
        }
      }
      for(int i = 0; i < remainingCorrect.length; i++) {
        for(int j = 0; j < 5; j++) {
          if(remainingCorrect[i] == tilesEntered[j + (currentRow * 5)].letter) {
            if(tilesEntered[j + (currentRow * 5)].answerStage != AnswerStage.correct) {
              tilesEntered[j + (currentRow * 5)].answerStage = AnswerStage.contains;
            }
            // final resultKey = keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * 5)]);
            final resultKey = keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * 5)].letter);
            if(resultKey.single.value != AnswerStage.correct) {
              keysMap.update(resultKey.single.key, (value) => AnswerStage.contains);
            }
            // print('contains ${remainingCorrect[i]}');
          }
        }
      }
      // print('word not guessed');
    }


    for(int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      if(tilesEntered[i].answerStage == AnswerStage.notAnswered) {
        tilesEntered[i].answerStage = AnswerStage.incorrect;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
      }
    }


    currentRow++;
    notifyListeners();
  }

}