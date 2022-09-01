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

  // DOES IT HAVE TO BE AN ARRAY/LIST????????
  /*
  List<DBPuzzles> _dataStoreFromSnapshot(QuerySnapshot snapshot) {
    List<DBPuzzles> arrayOfDBPuzzles = [];
    String gameMode = "Countries";
    snapshot.docs.forEach((doc) {
      if(doc.id == gameMode) {
        DBPuzzles dbPuzzles = DBPuzzles(
          puzzleList: doc['puzzleList'],
        );
        arrayOfDBPuzzles.add(dbPuzzles);
      }
    });
    return arrayOfDBPuzzles;
  }
   */

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

  /*
  List<CountriesAPI> _dataStoreFromSnapshot(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map<CountriesAPI>((doc){
        return CountriesAPI(
          countryList: doc.get('countryList'),
        );
      }).toList();
    } catch(e) {
      print("_dataStoreFromSnapshot not working");
      return snapshot.docs.map<CountriesAPI>((doc) {
        return CountriesAPI(
          countryList: doc.get('countryList'),
        );
      }).toList();
    }
  }

  Stream<List<CountriesAPI>> get countryAPI {
    return dataStoreCollection.snapshots().map<List<CountriesAPI>>(_dataStoreFromSnapshot);
  }
   */
}