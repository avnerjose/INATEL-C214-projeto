import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthHelper {
  Future<void> signUp(
      String name, String email, String password, bool rememberMe) async {
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
      rethrow;
    }
  }

  Future<void> signIn(String email, String password, bool rememberMe) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'wrong-password') {
        throw 'Email ou senha inválidos';
      } else if (e.code == 'user-not-found' || e.code == 'user-disabled') {
        throw 'Usuário não encontrado ou desativado';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> editProfile(
      String name, String email, String password, String photoURL) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;

      if (name != user.displayName && name.isNotEmpty) {
        await user.updateDisplayName(name);
      }
      if (email != user.email && email.isNotEmpty) {
        await user.updateEmail(email);
      }
      if (photoURL != user.photoURL && photoURL.isNotEmpty) {
        await user.updatePhotoURL(photoURL);
      }
      if (password.isNotEmpty) {
        await user.updatePassword(password);
      }
    } catch (e) {
      rethrow;
    }
  }
}
