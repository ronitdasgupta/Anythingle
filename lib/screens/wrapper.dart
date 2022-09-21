import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/models/dbPuzzles.dart';
import 'package:summerapp/screens/authenticate/authenticate.dart';
import 'package:summerapp/screens/authenticate/verify.dart';
import 'package:summerapp/screens/custom_wrapper.dart';
import 'package:summerapp/screens/home/home.dart';
import 'package:summerapp/services/auth.dart';
import 'package:summerapp/shared/loading.dart';

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

  final auth = FirebaseAuth.instance;
  // User? userFirebase;
  // late User userFirebase;
  // User? userFirebase;
  // late User userFirebase;
  User? userFirebase;
  
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

    // userFirebase = auth.currentUser!;

    /*
    if(userFirebase != null) {
      userFirebase = auth.currentUser;
    }
     */
    updateDataStoreInFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future<bool> checkEmail() async {
      userFirebase = auth.currentUser!;
      if(userFirebase == null) {
        return false;
      }
      await userFirebase?.reload();
      if(userFirebase!.emailVerified) {
        return true;
      }
      return false;
    }

    Future<StatefulWidget> checkEmailVerify() async {
      bool checkEmailVerified = await checkEmail();
      if(checkEmailVerified == true) {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        return Home();
      } else {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const VerifyScreen()));
        return const VerifyScreen();
      }
    }

    // bool checkEmailVerified = await checkEmail();

    final user = Provider.of<MyUser?>(context);

    if(user == null) {
      return  const Authenticate();
      // return Home();
    } else {
      if(user.emailVerified) {
        return CustomWrapper();
      } else {
        return VerifyScreen();
      }
      // checkEmailVerify();
    }
    // return Loading();
  }
}
