import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'authenticate/authenticate.dart';
import 'home/home.dart';

class CustomWrapper extends StatelessWidget {
  const CustomWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
