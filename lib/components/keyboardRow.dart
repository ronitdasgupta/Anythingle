import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        onTap: (){
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