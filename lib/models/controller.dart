import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/dbPuzzles.dart';
import 'package:summerapp/models/tile.dart';
import 'package:summerapp/screens/home/puzzles/countryPuzzle.dart';

import '../constant/answerStages.dart';
import '../data/keysMap.dart';

class Controller extends ChangeNotifier {

  String correctWord = "";
  int currentTile = 0, currentRow = 0;
  List<Tile> tilesEntered = [];
  List<String> countries = ["Kuwait", "Palau", "Moldova", "Angola", "Bolivia", "Tuvalu", "Peru",
    "Germany",
    "Botswana",
    "Hungary",
    "Canada",
    "Indonesia",
    "Taiwan",
    "Aruba",
    "Gabon",
    "Liberia",
    "Turkey",
    "Mali",
    "Benin",
    "Cyprus",
    "Somalia",
    "Niger",
    "Portugal",
    "Senegal",
    "Cuba",
    "Belarus",
    "Barbados",
    "Tunisia",
    "Israel",
    "Italy",
    "Myanmar",
    "Antarctica",
    "Micronesia",
    "Djibouti",
    "Gibraltar",
    "Belize",
    "Bermuda",
    "Australia",
    "Cameroon",
    "Russia",
    "Japan",
    "Honduras",
    "Burundi",
    "Paraguay",
    "Argentina",
    "Lesotho",
    "Sudan",
    "Kyrgyzstan",
    "Brazil",
    "Cambodia",
    "Montserrat",
    "Guatemala",
    "Azerbaijan",
    "Malaysia",
    "Colombia",
    "Mauritania",
    "Bahrain",
    "Belgium",
    "Chile",
    "Mozambique",
    "Ethiopia",
    "Guadeloupe",
    "Guam",
    "India",
    "Spain",
    "Kazakhstan",
    "Oman",
    "Poland",
    "Grenada",
    "Tajikistan",
    "Syria",
    "Libya",
    "Haiti",
    "Tonga",
    "Georgia",
    "Eritrea",
    "Tanzania",
    "Czechia",
    "Kosovo",
    "Bhutan",
    "Egypt",
    "Vietnam",
    "Austria",
    "Bahamas",
    "Croatia",
    "Slovenia",
    "Uzbekistan",
    "Finland",
    "Guyana",
    "Monaco",
    "Slovakia",
    "Yemen",
    "Malawi",
    "Gambia",
    "Panama",
    "Ireland",
    "Greece",
    "Guernsey",
    "Pakistan",
    "Armenia",
    "Malta",
    "Vanuatu",
    "Madagascar",
    "Laos",
    "Mongolia",
    "Martinique",
    "France",
    "Anguilla",
    "Eswatini",
    "Iceland",
    "Nepal",
    "Ghana",
    "Iraq",
    "Thailand",
    "Denmark",
    "Serbia",
    "Uganda",
    "Montenegro",
    "Jordan",
    "Suriname",
    "Kenya",
    "Mexico",
    "Seychelles",
    "Tokelau",
    "Bulgaria",
    "Latvia",
    "Guinea",
    "Lebanon",
    "Luxembourg",
    "Mauritius",
    "Estonia",
    "Norway",
    "Comoros",
    "Venezuela",
    "Iran",
    "Sweden",
    "Fiji",
    "Uruguay",
    "Macau",
    "Rwanda",
    "Albania",
    "Andorra",
    "Maldives",
    "Nauru",
    "Singapore",
    "Zimbabwe",
    "Dominica",
    "Morocco",
    "Mayotte",
    "Qatar",
    "Niue",
    "Romania",
    "Nicaragua",
    "Algeria",
    "Jamaica",
    "Togo",
    "Jersey",
    "Ecuador",
    "Samoa",
    "Nigeria",
    "Zambia",
    "Chad",
    "Lithuania",
    "Ukraine",
    "China",
    "Palestine",
    "Greenland",
    "Bangladesh",
    "Namibia",
    "Brunei",
    "Kiribati",
  ];

  String returnGuessedWord() {
    List<String> guessed = [], remainingCorrect = [];
    int counter = 0;
    String guessedWord = "";
    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        if(tilesEntered[i].letter != "") {
          guessed.add(tilesEntered[i].letter);
        }
    }
    guessedWord = guessed.join();
    print(guessedWord);
    return guessedWord;
  }

  String getCorrectWord() {
    setCorrectWord(word: correctWord);
    return correctWord;
  }

  bool guessedCorrect() {
    String guessedWord = returnGuessedWord();
    String correctWord = getCorrectWord();
    if(guessedWord == correctWord) {
      return true;
    }
    return false;
  }

  bool isValidWord() {
    List<String> guessed = [], remainingCorrect = [];
    int counter = 0;
    String guessedWord = "";
    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      if(i < tilesEntered.length) {
        if(tilesEntered[i].letter != "") {
          guessed.add(tilesEntered[i].letter);
        }
      }
    }
    guessedWord = guessed.join();
    for(int i = 0; i < countries.length; i++) {
      counter++;
      if(guessedWord == countries[i].toUpperCase()) {
        return true;
        // checkWord();
        // currentRow++;
      }
      if(counter > countries.length) {
        return false;
      }
    }
    return false;
  }

  bool checkWordBoolean() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";
    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      guessed.add(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();
    if(guessedWord == correctWord) {
      return true;
    } else {
      return false;
    }
  }

  bool wordGuessedCorrect() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";
    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      guessed.add(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();
    if(guessedWord == correctWord) {
      for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        specialKeyMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
      return true;
      // print('word guessed correct!');
    } else {
      for(int i = 0; i < correctWord.length; i++) {
        if(guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * correctWord.length)].answerStage = AnswerStage.correct;
          specialKeyMap.update(guessedWord[i], (value) => AnswerStage.correct);
          // Letter guessed at the correct spot
          // print('letter guessed at ${guessedWord[i]}');
        }
      }
      for(int i = 0; i < remainingCorrect.length; i++) {
        for(int j = 0; j < correctWord.length; j++) {
          if(remainingCorrect[i] == tilesEntered[j + (currentRow * correctWord.length)].letter) {
            if(tilesEntered[j + (currentRow * correctWord.length)].answerStage != AnswerStage.correct) {
              tilesEntered[j + (currentRow * correctWord.length)].answerStage = AnswerStage.contains;
            }
            // final resultKey = keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * 5)]);
            final resultKey = specialKeyMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * correctWord.length)].letter);
            if(resultKey.single.value != AnswerStage.correct) {
              specialKeyMap.update(resultKey.single.key, (value) => AnswerStage.contains);
            }
            // print('contains ${remainingCorrect[i]}');
          }
        }
      }
      // return false;
      // print('word not guessed');
    }


    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      if(tilesEntered[i].answerStage == AnswerStage.notAnswered) {
        tilesEntered[i].answerStage = AnswerStage.incorrect;
        specialKeyMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
      }
    }


    currentRow++;
    notifyListeners();
    return false;
  }

  void clearGrid() {
    //tilesEntered.add(Tile(letter: value, answerStage: AnswerStage.notAnswered));
    tilesEntered.clear();
    currentTile = 0;
    currentRow = 0;
  }

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({ required String value}) {
    if(value == 'ENTER') {
      // currentTile = correctWord.length * (currentRow - 1);
      int guessedCharacter = 0;
      // tilesEntered.add(Tile(letter: "X", answerStage: AnswerStage.notAnswered));
      // Check to see if the word entered is a valid country
      List<String> guessed = [], remainingCorrect = [];
      String guessedWord = "";
      for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        if(i < tilesEntered.length) {
          if(tilesEntered[i].letter != "") {
            guessed.add(tilesEntered[i].letter);
          }
        }
      }
      guessedWord = guessed.join();
      // guessedWord = guessedWord[0].toUpperCase() + guessedWord[guessedWord.length - 1].toLowerCase();
      // Check to see if the guessed word is a valid country
      // If it is allow the user to go to the next line and update the status of the letters
      // If it is not, notify the user to enter a valid country (use a snackbar?)
      // allDBPuzzles
      //CountryPuzzle
      // print(countries);




      for(int i = 0; i < countries.length; i++) {
        if(guessedWord == countries[i].toUpperCase()) {
          checkWord();
          // currentRow++;
        }
      }

      /*
      if(countries.contains(guessedWord)) {
        checkWord();
        currentRow++;
      }
       */


      // This if statement checks to see if enough letters are entered for the word of the day
      /*
      if(currentTile == correctWord.length * (currentRow + 1)) {
        // currentRow++;
        // checkWord();
        bool isWordCorrect = checkWordBoolean();
        /*
        if(isWordCorrect == true) {
          // exit(0);
          const snackBar = SnackBar(
            content: Text("Word guessed correct!"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        */
        print('check word');
      }
      */
    }
    if(value == 'BACK') {
      if(currentTile > correctWord.length * (currentRow + 1) - correctWord.length) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      List<String> guessed = [], remainingCorrect = [];
      String guessedWord = "";
      for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        if(i < tilesEntered.length) {
          guessed.add(tilesEntered[i].letter);
        }
      }
      guessedWord = guessed.join();
      int guessedCharacter = 0;
      if(currentTile < correctWord.length * (currentRow + 1) && value != "ENTER") {
        tilesEntered.add(Tile(letter: value, answerStage: AnswerStage.notAnswered));
        guessedCharacter++;
        currentTile++;
      }
    }
    notifyListeners();
    // print('current tile $currentTile and currentRow $currentRow');
  }

  checkWord() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";
    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      if(i < tilesEntered.length) {
        guessed.add(tilesEntered[i].letter);
      }
    }
    guessedWord = guessed.join();
    int letterCounter = 0;
    int lettersRemaining = correctWord.length - guessedWord.length;
    guessedWord = guessedWord.substring(0, guessedWord.length);
    while(letterCounter != lettersRemaining) {
      currentTile++;
      guessedWord = guessedWord.substring(0, guessedWord.length) + "1";
      guessed.add("1");
      tilesEntered.add(Tile(letter: "", answerStage: AnswerStage.notAnswered));
      letterCounter++;
    }
    remainingCorrect = correctWord.characters.toList();
    if(guessedWord == correctWord) {
      for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        specialKeyMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
      // print('word guessed correct!');
    } else {
      for(int i = 0; i < guessedWord.length; i++) {
        if(guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * correctWord.length)].answerStage = AnswerStage.correct;
          specialKeyMap.update(guessedWord[i], (value) => AnswerStage.correct);
          // Letter guessed at the correct spot
          // print('letter guessed at ${guessedWord[i]}');
        }
      }
      for(int i = 0; i < remainingCorrect.length; i++) {
        for(int j = 0; j < correctWord.length; j++) {
          if(remainingCorrect[i] == tilesEntered[j + (currentRow * correctWord.length)].letter) {
            if(tilesEntered[j + (currentRow * correctWord.length)].answerStage != AnswerStage.correct) {
              tilesEntered[j + (currentRow * correctWord.length)].answerStage = AnswerStage.contains;
            }
            // final resultKey = keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * 5)]);
            final resultKey = specialKeyMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * correctWord.length)].letter);
            if(resultKey.single.value != AnswerStage.correct) {
              specialKeyMap.update(resultKey.single.key, (value) => AnswerStage.contains);
            }
            // print('contains ${remainingCorrect[i]}');
          }
        }
      }
      // print('word not guessed');
    }


    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      if(tilesEntered[i].answerStage == AnswerStage.notAnswered) {
        tilesEntered[i].answerStage = AnswerStage.incorrect;
        specialKeyMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
      }
    }


    currentRow++;
    notifyListeners();
  }

  bool booleanCheckWord() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";
    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      if(i < tilesEntered.length) {
        guessed.add(tilesEntered[i].letter);
      }
    }
    guessedWord = guessed.join();
    int letterCounter = 0;
    int lettersRemaining = correctWord.length - guessedWord.length;
    guessedWord = guessedWord.substring(0, guessedWord.length);
    while(letterCounter != lettersRemaining) {
      guessedWord = guessedWord.substring(0, guessedWord.length) + "1";
      letterCounter++;
    }
    remainingCorrect = correctWord.characters.toList();
    if(guessedWord == correctWord) {
      return true;
      for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        specialKeyMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
      return true;
      // print('word guessed correct!');
    } else {
      for(int i = 0; i < guessedWord.length; i++) {
        if(guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * correctWord.length)].answerStage = AnswerStage.correct;
          specialKeyMap.update(guessedWord[i], (value) => AnswerStage.correct);
          // Letter guessed at the correct spot
          // print('letter guessed at ${guessedWord[i]}');
        }
      }
      for(int i = 0; i < remainingCorrect.length; i++) {
        for(int j = 0; j < correctWord.length; j++) {
          if(remainingCorrect[i] == tilesEntered[j + (currentRow * correctWord.length)].letter) {
            if(tilesEntered[j + (currentRow * correctWord.length)].answerStage != AnswerStage.correct) {
              tilesEntered[j + (currentRow * correctWord.length)].answerStage = AnswerStage.contains;
            }
            // final resultKey = keysMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * 5)]);
            final resultKey = specialKeyMap.entries.where((element) => element.key == tilesEntered[j + (currentRow * correctWord.length)].letter);
            if(resultKey.single.value != AnswerStage.correct) {
              specialKeyMap.update(resultKey.single.key, (value) => AnswerStage.contains);
            }
            // print('contains ${remainingCorrect[i]}');
          }
        }
      }
      // print('word not guessed');
    }


    for(int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      if(tilesEntered[i].answerStage == AnswerStage.notAnswered) {
        tilesEntered[i].answerStage = AnswerStage.incorrect;
        specialKeyMap.update(tilesEntered[i].letter, (value) => AnswerStage.incorrect);
      }
    }


    currentRow++;
    notifyListeners();
    return false;
  }

}