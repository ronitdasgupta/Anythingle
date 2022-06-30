class GameMode {
  final String game;
  final PuzzleInfo puzzleInfo;

  GameMode({ required this.game, required this.puzzleInfo});

  /*
  factory GameMode.fromJson(Map<String, dynamic> json) {
    return GameMode(
      game: json[game],
    );
  }
   */
}


class PuzzleInfo {
  final String answer;

  PuzzleInfo({ required this.answer });

  factory PuzzleInfo.fromJson(Map<String, dynamic> json) {
    return PuzzleInfo(
      answer: json['answer'],
    );
  }

  static List<PuzzleInfo> fromJsonArray(List<dynamic> jsonArray) {
    List<PuzzleInfo> arrayOfPuzzles = [];

    jsonArray.forEach((jsonData) {
      arrayOfPuzzles.add(PuzzleInfo.fromJson(jsonData));
    });
    return arrayOfPuzzles;
  }

  Map<String, dynamic> toJson() {
    return {
      "answer" : answer,
    };
  }
}

/*
class PuzzlesInfo {
  final List<dynamic> dates;
  final String gameMode;

  PuzzlesInfo({ required this.dates, required this.gameMode });
}
 */