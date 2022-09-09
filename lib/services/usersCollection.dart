import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summerapp/models/countryInfo.dart';

class UsersCollection {
  final String uid;
  UsersCollection({ required this.uid });

  final CollectionReference users = FirebaseFirestore.instance.collection('Users');

  // writes to users collection
  Future updateUserInfo(String username) async {
    return await users.doc(uid).set({
      'username': username,
    });
  }
}