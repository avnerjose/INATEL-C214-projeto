import 'package:books_app/controllers/firebase_auth.dart';
import 'package:books_app/shared/exceptions/email_already_used.dart';
import 'package:books_app/shared/exceptions/invalid_password_or_email.dart';
import 'package:books_app/shared/exceptions/user_not_found.dart';
import 'package:books_app/shared/exceptions/weak_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  final mockUser = MockUser(
    isAnonymous: false,
    uid: "mocked-uid",
    email: "mocked-email",
    displayName: "mocked-name",
  );
  MockFirebaseAuth mockFirebaseAuth;

  group("signUp", () {
    test("should be able to sign up when data is valid", () async {
      mockFirebaseAuth = MockFirebaseAuth();
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);

      final credential = await firebaseAuthHelper.signUp(
          "mocked-name", "mocked-email", "mocked-password", false);

      final createdUser = credential?.user;

      expect(createdUser?.displayName, "mocked-name");
      expect(createdUser?.email, "mocked-email");
    });

    test("should throw WeakPasswordException when auth throws weak-password",
        () async {
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          createUserWithEmailAndPassword:
              FirebaseAuthException(code: "weak-password"),
        ),
      );
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);
      expect(
          () => firebaseAuthHelper.signUp(
              "mocked-name", "mocked-email", "123", false),
          throwsA(isA<WeakPasswordException>()));
    });
    test("should throw EmailAlreadyUsed when auth throws email-already-in-use",
        () async {
      mockFirebaseAuth = MockFirebaseAuth(
        authExceptions: AuthExceptions(
          createUserWithEmailAndPassword:
              FirebaseAuthException(code: "email-already-in-use"),
        ),
      );
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);
      expect(
          () => firebaseAuthHelper.signUp(
              "mocked-name", "mocked-email", "123", false),
          throwsA(isA<EmailAlreadyUsedException>()));
    });
  });

  group("signIn", () {
    test("should be able to sign in when data is valid", () async {
      mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);

      final credential = await firebaseAuthHelper.signIn(
          "mocked-email", "mocked-password", false);
      final signedInUser = credential?.user;

      expect(signedInUser?.displayName, "mocked-name");
      expect(signedInUser?.email, "mocked-email");
    });
    test(
        "should throw InvalidPasswordOrEmailException when throws invalid-email",
        () async {
      mockFirebaseAuth = MockFirebaseAuth(
          authExceptions: AuthExceptions(
            signInWithEmailAndPassword:
                FirebaseAuthException(code: "invalid-email"),
          ),
          mockUser: mockUser);
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);
      expect(
          () => firebaseAuthHelper.signIn(
              "mocked-email-invalid", "mocked-password", false),
          throwsA(isA<InvalidPasswordOrEmailException>()));
    });
    test(
        "should throw InvalidPasswordOrEmailException when throws wrong-password",
        () async {
      mockFirebaseAuth = MockFirebaseAuth(
          authExceptions: AuthExceptions(
            signInWithEmailAndPassword:
                FirebaseAuthException(code: "wrong-password"),
          ),
          mockUser: mockUser);
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);
      expect(
          () => firebaseAuthHelper.signIn(
              "mocked-email-invalid", "mocked-password", false),
          throwsA(isA<InvalidPasswordOrEmailException>()));
    });
    test("should throw UserNotFoundException when throws user-not-found",
        () async {
      mockFirebaseAuth = MockFirebaseAuth(
          authExceptions: AuthExceptions(
            signInWithEmailAndPassword:
                FirebaseAuthException(code: "user-not-found"),
          ),
          mockUser: mockUser);
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);
      expect(
          () => firebaseAuthHelper.signIn(
              "mocked-email-invalid", "mocked-password", false),
          throwsA(isA<UserNotFoundException>()));
    });
    test("should throw UserNotFoundException when throws user-disabled",
        () async {
      mockFirebaseAuth = MockFirebaseAuth(
          authExceptions: AuthExceptions(
            signInWithEmailAndPassword:
                FirebaseAuthException(code: "user-disabled"),
          ),
          mockUser: mockUser);
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);
      expect(
          () => firebaseAuthHelper.signIn(
              "mocked-email-invalid", "mocked-password", false),
          throwsA(isA<UserNotFoundException>()));
    });
  });

  group("editProfile", () {
    test("should be able to edit profile", () async {
      mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: false);
      final firebaseAuthHelper = FirebaseAuthHelper(mockFirebaseAuth);
      await firebaseAuthHelper.signOut();
      mockFirebaseAuth.authStateChanges().listen((event) {
        expect(event, null);
      });
    });
  });
}
