import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:summerapp/models/puzzleInfo.dart';

class PuzzlesCollection {

  final CollectionReference puzzles = FirebaseFirestore.instance.collection('Puzzles');

  // Reads data from collection
  List<PuzzleInfo> _puzzleInfoFromSnapshot(QuerySnapshot snapshot) {
    List<PuzzleInfo> arrayOfPuzzlesInfo = [];
    snapshot.docs.forEach((date) {
      PuzzleInfo eachPuzzleInfo = PuzzleInfo(
        answer: date['answer'],
      );
      arrayOfPuzzlesInfo.add(eachPuzzleInfo);
    });
    return arrayOfPuzzlesInfo;
  }

  // Writes data to collection
  Future updatePuzzleCollection(GameMode gameMode, String gameType) async {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      return await puzzles.doc(currentDate).set({
        // gameType: gameMode,
        gameMode,
        // gameType: gameMode.,
      }, SetOptions(merge: true));
    } catch(e) {
      print(e.toString());
    }
  }

  Future testUpdatePuzzleCollection(GameMode gameMode, String gameType) async {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      return await puzzles.doc(currentDate).set({
        'country': {
          // 'answer': gameMode.puzzleInfo,
          'answer': 'Kenya',
        }
      }, SetOptions(merge: true));
    } catch(e) {
      print(e.toString());
    }
  }

  Stream<List<PuzzleInfo>> get puzzleInfo {
    return puzzles.snapshots().map<List<PuzzleInfo>>(_puzzleInfoFromSnapshot);
  }

}