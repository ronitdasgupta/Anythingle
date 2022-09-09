import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String bullet = "\u2022 ";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text(
          "Help",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Text(
              bullet + "Guess the Anythingle in 6 tries.                                          ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "Guesses can be shorter than the actual puzzle word.                                ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "However, each guess has to be a valid word specific to the game mode.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "Past puzzles can also be played by changing the date.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "After each valid guess, the color of the tiles will change.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "If the tile color is green, it means that the guessed letter is in the word and in the correct position.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "If the tile color is yellow, it means that the guessed letter in the word but in the wrong position.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "If the tile color is gray, it means that the guessed letter is not in the word.",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              bullet + "New puzzles for each game mode are available every day!",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "Have fun!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
