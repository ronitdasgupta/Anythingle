import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/tile.dart';

import '../constant/answerStages.dart';
import '../constant/colors.dart';
import '../data/keysMap.dart';
import '../models/controller.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({ required this.min, required this.max,
    Key? key,
  }) : super(key: key);

  final int min, max;


  @override
  Widget build(BuildContext context) {

    /*
    bool isWordCorrect() {
      String correctWord = Provider.of<Controller>(context, listen: false).getCorrectWord();
      List<Tile> guessedWord = Provider.of<Controller>(context, listen: false).tilesEntered;
      int guessedWordCounter = guessedWord.length - 1;
      int counter = 0;
      for(int i = correctWord.length - 1; i >= 0; i--) {
        if(correctWord[i] != guessedWord[guessedWordCounter]){
          return false;
        } else {
          guessedWordCounter--;
          counter++;
        }
        if(counter == 6) {
          return true;
        }
      }
      return true;
    }

    bool test = isWordCorrect();
     */

    final size = MediaQuery.of(context).size;
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        int index = 0;
        return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keysMap.entries.map((e) {
          index++;
          if(index >= min && index <= max) {
            Color color = Theme.of(context).primaryColorLight;
            Color keyColor = Colors.white;
            if(e.value == AnswerStage.correct) {
              color = correctGreen;
            } else if(e.value == AnswerStage.contains) {
              color = containsYellow;
            } else if(e.value == AnswerStage.incorrect) {
              color = Theme.of(context).primaryColorDark;
            } else {
              keyColor = Theme.of(context).textTheme.bodyText2?.color ?? Colors.black;
            }


            return Padding(
              padding: EdgeInsets.all(size.width * 0.006),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                    width: e.key == 'ENTER' || e.key == 'BACK' ?
                    size.width * 0.13 :
                    size.width * 0.085,
                    height: size.height * 0.090,
                    child: Material(
                      color: color,
                      child: InkWell(
                        onTap: () async {
                          if(e.key == "ENTER"){
                            if(Provider.of<Controller>(context, listen: false).isValidWord() == false) {
                              final errorSnackBar = SnackBar(
                                backgroundColor: Colors.red,
                                // content: Text("Word guessed correct!"),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.info, size: 32),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        "Enter a valid country",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                            }
                            /*
                            if(Provider.of<Controller>(context, listen: false).tilesEntered.length != Provider.of<Controller>(context, listen: false).getCorrectWord().length) {
                                Provider.of<Controller>(context, listen: false).setKeyTapped(value: "");
                            }
                             */
                            Provider.of<Controller>(context, listen: false).setKeyTapped(value: e.key);
                            //Provider.of<Controller>(context, listen: false).returnGuessedWord();
                            //String guessedWord = Provider.of<Controller>(context, listen: false).returnGuessedWord();
                            //print(guessedWord);
                            //Provider.of<Controller>(context, listen: false).getCorrectWord();
                            // String guessedWord = Provider.of<Controller>(context, listen: false).returnGuessedWord();
                            // print(guessedWord);
                            String correctWord = Provider.of<Controller>(context, listen: false).getCorrectWord();
                            print(correctWord);
                            List<Tile> guessedWord = Provider.of<Controller>(context, listen: false).tilesEntered;
                            print(guessedWord);
                            List<String> guessed = [];
                            String guessedWordString = "";
                            int guessedWordIndex = guessedWord.length - 1;
                            int letterCounter = 0;
                            for(int i = correctWord.length - 1; i >= 0; i--) {
                              if(correctWord[i] == guessedWord[guessedWordIndex].letter) {
                                letterCounter++;
                                guessedWordIndex--;
                              }
                            }

                            /*
                            for(int i = 0; i < guessedWord.length; i++) {
                              guessed.add(guessedWord[i].letter);
                            }
                            guessedWordString = guessed.join();
                            print(guessedWordString);
                             */



                            if(letterCounter == correctWord.length) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
                                // content: Text("Word guessed correct!"),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Icon(Icons.check, size: 32),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        "Word guessed correct!",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              await Future.delayed(Duration(seconds: 5));
                              exit(0);
                            }
                          }
                          Provider.of<Controller>(context, listen: false)
                              .setKeyTapped(value: e.key);


                          /*
                          if(Provider.of<Controller>(context, listen: false).checkWordBoolean() == true) {
                            Provider.of<Controller>(context, listen: false)
                                .setKeyTapped(value: e.key);
                          }
                          */
                        },
                        child: Center(child: Text(e.key, style:
                        Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: keyColor,
                        ))),
                      ),
                    )),
              ),
            );
          } else {
            return const SizedBox();
          }
          //print('index os $index of key: ${e.key}');
          return Text(e.key);
        }).toList(),
      );
      },
    );
  }
}