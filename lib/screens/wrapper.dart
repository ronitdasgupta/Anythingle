import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summerapp/screens/authenticate/authenticate.dart';
import 'package:summerapp/screens/home/home.dart';

import '../models/puzzleInfo.dart';
import '../models/user.dart';
import '../services/puzzlesCollection.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

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
