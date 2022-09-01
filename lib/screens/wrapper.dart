import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/dbPuzzles.dart';
import 'package:summerapp/screens/authenticate/authenticate.dart';
import 'package:summerapp/screens/home/home.dart';

import '../models/puzzleInfo.dart';
import '../models/user.dart';
import '../services/dataStoreCollection.dart';
import '../services/puzzlesCollection.dart';
import 'home/countries.dart';
import 'package:http/http.dart' as http;

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  
  Future<void> updateDataStoreInFirestore() async {
    final DataStoreCollection dataStoreCollection = DataStoreCollection();
    var response = await http.get(Uri.https('restcountries.com', 'v3.1/all'));
    var jsonData = jsonDecode(response.body);
    List<String> currentCountries = [];
    for(var u in jsonData) {
      Country country = Country(u['name']['common']);
      if(country.common.length < 11 && !country.common.contains(" ") && country.common != "CuraÃ§ao" && country.common != "RÃ©union") {
        currentCountries.add(country.common);
      }
    }
    DBPuzzles countriesAPI = DBPuzzles(puzzleList: currentCountries, gameMode: "Countries");
    // countriesAPI.countryList = currentCountries;
    dynamic result = await dataStoreCollection.updateDataStoreInfo(countriesAPI.puzzleList, 'Countries');
    if(result == null) {
      setState(() {
        print('error from api method');
      });
    }
  }

  @override
  void initState() {
    updateDataStoreInFirestore();
    // dynamic result = await
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);

    if(user == null) {
      return Authenticate();
      // return Home();
    } else {
      // return PuzzlesWrapper();
      return Home();
    }

    /*
    return StreamProvider<List<PuzzlesInfo>>.value(
        value: PuzzlesCollection().puzzleInfo,
        initialData: [],
        child: PuzzlesWrapper(),
    );
     */

    /*
    else {
      return Home();
    }
     */
  }
}
