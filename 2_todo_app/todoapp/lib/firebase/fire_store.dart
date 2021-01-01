import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/constants/db_constants.dart';
import 'package:todoapp/model/post.dart';

class FireStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Post> data;

  createUser(String uid, String nickname) {
    CollectionReference users = firestore.collection(COLLECTION);
    users.doc(uid).set({NICKNAME: nickname});
  }

  postSchedule(
      String uid, String date, String content, String time, int count) async {
    CollectionReference post = firestore.collection(COLLECTION);

    await post
        .doc(uid)
        .collection(date)
        .doc()
        .set({CONTENT: content, TIME: time, COUNT: count});
  }

  getSchedule(String uid, String date) async {
    data = new List<Post>();
    CollectionReference post = firestore.collection(COLLECTION);

    await post
        .doc(uid)
        .collection(date)
        .orderBy(COUNT)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                data.add(
                    new Post(doc.get(CONTENT), doc.get(TIME), doc.id, date));
              })
            });
  }

  getData() {
    return data;
  }

  deleteSchedule(String uid, String date, String id) async {
    CollectionReference post = firestore.collection(COLLECTION);
    await post.doc(uid).collection(date).doc(id).delete();
  }
}
