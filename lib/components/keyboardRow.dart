import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/tile.dart';
import 'package:summerapp/screens/custom_wrapper.dart';
import 'package:summerapp/screens/home/geography.dart';
import 'package:summerapp/screens/home/home.dart';
import 'package:summerapp/screens/wrapper.dart';

import '../constant/answerStages.dart';
import '../constant/colors.dart';
import '../data/keysMap.dart';
import '../models/controller.dart';
import '../models/user.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({ required this.min, required this.max,
    Key? key,
  }) : super(key: key);

  final int min, max;


  @override
  Widget build(BuildContext context) {
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
                                duration: const Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                            }
                            Provider.of<Controller>(context, listen: false).setKeyTapped(value: e.key);
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
                            // If the user is on the last row and the word entered is wrong, then display the correct word in snack bar.
                            if(Provider.of<Controller>(context, listen: false).currentRow == 6 && letterCounter != correctWord.length) {
                              final showCorrectWord = SnackBar(
                                backgroundColor: Colors.grey,
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.info, size: 32),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        "The correct word is: " + correctWord,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                                duration: const Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(showCorrectWord);
                            }

                            if(letterCounter == correctWord.length) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.green,
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
                                duration: const Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              await Future.delayed(const Duration(seconds: 2));
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const CustomWrapper()),
                                );
                            }
                          }
                          Provider.of<Controller>(context, listen: false)
                              .setKeyTapped(value: e.key);
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