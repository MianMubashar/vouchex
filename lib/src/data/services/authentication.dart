import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future resetPass(String email) async {
    try {
      return await auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future signOut() async {
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic('all');
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}