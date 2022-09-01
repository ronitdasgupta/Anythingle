import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:summerapp/models/puzzleInfo.dart';

class PuzzlesCollection {

  String gameMode;
  // String dateSelected;
  final String? dateSelected;

  PuzzlesCollection({ required this.gameMode, this.dateSelected });

  final CollectionReference puzzles = FirebaseFirestore.instance.collection('Puzzles');
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Reads data from collection
  List<PuzzleInfo> _puzzleInfoFromSnapshot(QuerySnapshot snapshot) {
    try{
      List<PuzzleInfo> arrayOfPuzzlesInfo = [];
      var map = new Map<String, PuzzleInfo>();
      snapshot.docs.forEach((date) {
        /*
        if(date.id == dateSelected) {
          PuzzleInfo eachPuzzleInfo = PuzzleInfo(
            answer: date[gameMode]['answer'],
            // answer: date['country']['answer'],
          );
          arrayOfPuzzlesInfo.add(eachPuzzleInfo);
        }
         */
        PuzzleInfo eachPuzzleInfo = PuzzleInfo(
          answer: date[gameMode]['answer'],
          // answer: date['country']['answer'],
          // selectedDate: dateSelected,
          date: date['date'],
        );
        // map[date.id] = eachPuzzleInfo;
        arrayOfPuzzlesInfo.add(eachPuzzleInfo);
      });
      return arrayOfPuzzlesInfo;
      // return map;
    } catch(e) {
      print("_puzzleInfoFromSnapshot error");
      List<PuzzleInfo> arrayOfPuzzlesInfo = [];
      var map = new Map<String, PuzzleInfo>();
      snapshot.docs.forEach((date) {
        /*
        if(date.id == dateSelected) {
          PuzzleInfo eachPuzzleInfo = PuzzleInfo(
            answer: date[gameMode]['answer'],
            // answer: date['country']['answer'],
          );
          arrayOfPuzzlesInfo.add(eachPuzzleInfo);
        }
         */
        PuzzleInfo eachPuzzleInfo = PuzzleInfo(
          answer: date[gameMode]['answer'],
          // answer: date['country']['answer'],
          // selectedDate: date[gameMode]['date'],
          // selectedDate: dateSelected,
          date: date['date'],
        );
        map[date.id] = eachPuzzleInfo;
        arrayOfPuzzlesInfo.add(eachPuzzleInfo);
      });
      return arrayOfPuzzlesInfo;
      // return map;
    }
  }

  List<PuzzleInformationDB> _puzzleInformationFromSnapshot(QuerySnapshot snapshot) {
    try {
      List<PuzzleInformationDB> arrayOfPuzzleInformation = [];
      snapshot.docs.forEach((dateDoc) {
        PuzzleInfo eachPuzzleInfo = PuzzleInfo(
          answer: dateDoc[gameMode]['answer'],
          // selectedDate: dateSelected,
          date: dateDoc['date'],
        );
        PuzzleInformationDB eachPuzzleInformation = PuzzleInformationDB(
          puzzleInfo: eachPuzzleInfo,
          date: dateDoc.id,
        );
        arrayOfPuzzleInformation.add(eachPuzzleInformation);
      });
      return arrayOfPuzzleInformation;
    }
    catch(e) {
      print("error in _puzzleInformationFromSnapshot");
      List<PuzzleInformationDB> arrayOfPuzzleInformation = [];
      snapshot.docs.forEach((dateDoc) {
        PuzzleInfo eachPuzzleInfo = PuzzleInfo(
          answer: dateDoc[gameMode]['answer'],
          // selectedDate: dateSelected,
          date: dateDoc['date'],
        );
        PuzzleInformationDB eachPuzzleInformation = PuzzleInformationDB(
          puzzleInfo: eachPuzzleInfo,
          date: dateDoc.id,
        );
        arrayOfPuzzleInformation.add(eachPuzzleInformation);
      });
      return arrayOfPuzzleInformation;
    }
  }

  /*
  List<PuzzleInformation> _puzzleInformationFromSnapshot(QuerySnapshot snapshot) {
    try {
      List<PuzzleInformation> arrayOfPuzzlesInformation = [];
      snapshot.docs.forEach((date) {
        PuzzleInfo eachPuzzleInfo = PuzzleInfo(
          answer: date[gameMode]['answer'],
        );
        PuzzleInformation eachPuzzleInformation = PuzzleInformation(
          // eachPuzzleInfo: eachPuzzleInfo.answer,
          answer: eachPuzzleInfo.answer,
          date: date['date'],
        );
        arrayOfPuzzlesInformation.add(eachPuzzleInformation);
      });
      return arrayOfPuzzlesInformation;
    } catch(e) {
      List<PuzzleInformation> arrayOfPuzzlesInformation = [];
      snapshot.docs.forEach((date) {
        PuzzleInfo eachPuzzleInfo = PuzzleInfo(
          answer: date[gameMode]['answer'],
        );
        PuzzleInformation eachPuzzleInformation = PuzzleInformation(
          // eachPuzzleInfo: eachPuzzleInfo.answer,
          answer: eachPuzzleInfo.answer,
          date: date['date'],
        );
        arrayOfPuzzlesInformation.add(eachPuzzleInformation);
      });
      return arrayOfPuzzlesInformation;
    }
  }
   */

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

  Future testUpdatePuzzleCollection(GameMode gameMode, String gameType, String selectedDate) async {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    try {
      return await puzzles.doc(currentDate).set({
        'country': {
          'answer': gameMode.puzzleInfo.answer,
          // 'answer': 'Indonesia',
        },
        'date': currentDate,
        // 'selectedDate': selectedDate,
      }, SetOptions(merge: true));
    } catch(e) {
      print(e.toString());
    }
  }

  /*
  Stream<List<PuzzleInfo>> get puzzleInformation {
    return puzzles.snapshots().map<List<PuzzleInfo>>(_puzzleInfoFromSnapshot);
  }
   */

  Stream<List<PuzzleInformationDB>> get puzzleInformation {
    return puzzles.snapshots().map<List<PuzzleInformationDB>>(_puzzleInformationFromSnapshot);
  }

  Stream<List<PuzzleInfo>> get puzzleInfo {
    return puzzles.snapshots().map<List<PuzzleInfo>>(_puzzleInfoFromSnapshot);
  }
}