import 'package:todoapp/firebase/fire_auth.dart';
import 'package:todoapp/firebase/fire_store.dart';

FireStore fs = new FireStore();
FireAuth fa = new FireAuth();

final COLLECTION = "users";
final NICKNAME = "nickname";
final CONTENT = "content";
final COUNT = "count";
final TIME = "time";
