import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/firebase/fire_store.dart';

class FireAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  FireStore fs = new FireStore();

  registerUser(
      String email, String nickname, String password, String repassword) async {
    print("hi");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      fs.createUser(auth.currentUser.uid, nickname);
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
