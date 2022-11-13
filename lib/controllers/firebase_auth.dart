import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthHelper {
  Future<void> signUp(
      String name, String email, String password, bool rememberMe) async {
    try {
      await handleRememberMe(rememberMe);
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

  Future<void> signIn(String email, String password, bool rememberMe) async {
    try {
      await handleRememberMe(rememberMe);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'wrong-password') {
        throw 'Email ou senha inválidos';
      } else if (e.code == 'user-not-found' || e.code == 'user-disabled') {
        throw 'Usuário não encontrado ou desativado';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> handleRememberMe(bool rememberMe) async {
    final auth = FirebaseAuth.instanceFor(
        app: Firebase.app(), persistence: Persistence.NONE);

    if (rememberMe) {
      await auth.setPersistence(Persistence.LOCAL);
    }
  }
}
