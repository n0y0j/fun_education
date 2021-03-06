import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/utils/constants/db_constants.dart';

class FireAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;

  FireAuth() {
    user = auth.currentUser;
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

      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
