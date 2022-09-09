import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/dbPuzzles.dart';

class DataStoreCollection {
  final CollectionReference dataStoreCollection = FirebaseFirestore.instance.collection('DataStore');

  Future updateDataStoreInfo(List<String> puzzleList, String gameMode) async {
    return await dataStoreCollection.doc(gameMode).set({
      'puzzleList': puzzleList,
      'gameMode': gameMode,
    });
  }

  List<DBPuzzles> _dataStoreFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map<DBPuzzles>((doc) {
        return DBPuzzles(
            puzzleList: List.from(doc.get('puzzleList')),
            gameMode: doc.get('gameMode') ?? '',
        );
      }).toList();
    } catch(e) {
      print("_dataStoreFromSnapshot not working");
      return snapshot.docs.map<DBPuzzles>((doc) {
        return DBPuzzles(
          puzzleList: List.from(doc.get('puzzleList')),
          gameMode: doc.get('gameMode') ?? '',
        );
      }).toList();
    }
  }

  Stream<List<DBPuzzles>> get dbPuzzles {
    return dataStoreCollection.snapshots().map<List<DBPuzzles>>(_dataStoreFromSnapshot);
  }
}