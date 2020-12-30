import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/firebase/fire_store.dart';

class FireAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FireStore fs = new FireStore();
  String uid;

  FireAuth() {
    prepareUser();
  }

  prepareUser() {
    uid = auth.currentUser.uid;
  }

  registerUser(
      String email, String nickname, String password, String repassword) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      fs.createUser(auth.currentUser.uid, nickname);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
