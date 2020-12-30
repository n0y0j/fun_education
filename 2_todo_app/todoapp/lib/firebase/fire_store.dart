import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/people.dart';

class FireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createUser(String uid, String nickname) {
    CollectionReference users = firestore.collection('users');
    users.doc(uid).set({'nickname': nickname});
  }
}
