import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/model/post.dart';

class FireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Post> data;

  createUser(String uid, String nickname) {
    CollectionReference users = firestore.collection('users');
    users.doc(uid).set({'nickname': nickname});
  }

  postSchedule(
      String uid, String date, String content, String time, int count) async {
    CollectionReference post = firestore.collection('users');

    await post
        .doc(uid)
        .collection(date)
        .doc()
        .set({'content': content, 'time': time, 'count': count});
  }

  getSchedule(String uid, String date) async {
    data = new List<Post>();
    CollectionReference post = firestore.collection('users');

    await post
        .doc(uid)
        .collection(date)
        .orderBy("count")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                data.add(new Post(
                    doc.get('content'), doc.get('time'), doc.id, date));
              })
            });
  }

  getData() {
    return data;
  }

  deleteSchedule(String uid, String date, String id) async {
    CollectionReference post = firestore.collection('users');
    await post.doc(uid).collection(date).doc(id).delete();
  }
}
