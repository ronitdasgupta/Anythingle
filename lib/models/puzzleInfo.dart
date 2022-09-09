class GameMode {
  final String game;
  final PuzzleInfo puzzleInfo;

  GameMode({ required this.game, required this.puzzleInfo});

}


class PuzzleInfo {
  final String answer;
  final String date;

  PuzzleInfo({ required this.answer, required this.date });

  factory PuzzleInfo.fromJson(Map<String, dynamic> json) {
    return PuzzleInfo(
      answer: json['answer'],
      date: "",
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

class PuzzleInformationDB {
  final PuzzleInfo puzzleInfo;
  final String date;

  // PuzzleInformationDB(this.puzzleInfo, this.date);
  PuzzleInformationDB({required this.puzzleInfo, required this.date});
}