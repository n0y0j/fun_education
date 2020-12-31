import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createUser(String uid, String nickname) {
    CollectionReference users = firestore.collection('users');
    users.doc(uid).set({'nickname': nickname});
  }

  postSchedule(String uid, String date, String content, String time) {
    CollectionReference post = firestore.collection('users');

    post
        .doc(uid)
        .collection('post')
        .doc(date)
        .set({'content': content, 'time': time});
  }
}
