import 'package:books_app/shared/exceptions/email_already_used.dart';
import 'package:books_app/shared/exceptions/invalid_password_or_email.dart';
import 'package:books_app/shared/exceptions/user_not_found.dart';
import 'package:books_app/shared/exceptions/weak_password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthHelper(this._firebaseAuth);

  Future<UserCredential?> signUp(
      String name, String email, String password, bool rememberMe) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      await user?.updateDisplayName(name);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyUsedException();
      }
    } catch (e) {
      rethrow;
    }

    return null;
  }

  Future<UserCredential?> signIn(
      String email, String password, bool rememberMe) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'wrong-password') {
        throw InvalidPasswordOrEmailException();
      } else if (e.code == 'user-not-found' || e.code == 'user-disabled') {
        throw UserNotFoundException();
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User?> editProfile(
      String name, String email, String password, String photoURL) async {
    try {
      User user = _firebaseAuth.currentUser!;

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
    return null;
  }
}
