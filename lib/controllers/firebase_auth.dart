import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  Future<void> signUp(String name, String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      await user?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw "A senha é muito fraca";
      } else if (e.code == 'email-already-in-use') {
        throw "O email já está sendo usado";
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
