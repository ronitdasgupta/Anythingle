import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/answerStages.dart';
import '../constant/colors.dart';
import '../models/controller.dart';

class GridTile extends StatefulWidget {
  const GridTile({required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  State<GridTile> createState() => _GridTileState();
}

class _GridTileState extends State<GridTile> {

  Color _backgroundColor = Colors.transparent, _borderColor = Colors.transparent;
  late AnswerStage _answerStage;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _borderColor = Theme.of(context).primaryColorLight;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        String text = "";
        Color fontColor = Colors.white;
        if(widget.index < notifier.tilesEntered.length) {
          text = notifier.tilesEntered[widget.index].letter;
          _answerStage = notifier.tilesEntered[widget.index].answerStage;

          if(_answerStage == AnswerStage.correct) {
            _borderColor = Colors.transparent;
            _backgroundColor = correctGreen;
          } else if(_answerStage == AnswerStage.contains) {
            _borderColor = Colors.transparent;
            _backgroundColor = containsYellow;
          } else if(_answerStage == AnswerStage.incorrect) {
            _borderColor = Colors.transparent;
            _backgroundColor = Theme.of(context).primaryColorDark;
          } else {
            // fontColor = Theme.of(context).textTheme.bodyText2?.color ?? Colors.black;
            fontColor = Theme.of(context).textTheme.bodyText2?.color ?? Colors.white;
          }

          return Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              border: Border.all(
                color: _borderColor,
              ),
            ),
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(text, style: TextStyle().copyWith(
                        color: fontColor,
                      )))));
        } else {
          return Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              border: Border.all(
                color: _borderColor,
              ),
            ),
          );
        }
      });
  }
}