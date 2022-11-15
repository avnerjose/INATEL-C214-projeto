import 'package:books_app/models/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDBHelper {
  final _auth = FirebaseAuth.instance;

  Future<void> storeBook(Book book) async {
    final ref = FirebaseDatabase.instance
        .ref('books/${_auth.currentUser!.uid}/${book.id}');

    await ref.set(book.toJson());
  }

  Future<void> deleteBook(String id) {
    final ref =
        FirebaseDatabase.instance.ref('books/${_auth.currentUser!.uid}/$id');

    return ref.remove();
  }

  Future<void> updateBook(Book book) async {
    final ref = FirebaseDatabase.instance
        .ref('books/${_auth.currentUser!.uid}/${book.id}');

    await ref.update(book.toJson());
  }

  Future<List<Book>> getAllBooks() async {
    final ref =
        FirebaseDatabase.instance.ref('books/${_auth.currentUser!.uid}');
    final snapshot = await ref.get();

    if (snapshot.value == null) {
      return [];
    }
    
    final value = snapshot.value as Map<dynamic, dynamic>;
    List<Book> books = [];

    value.forEach((key, value) {
      books.add(Book.fromJson(value));
    });

    return books;
  }

  Future<Book?> getBookById(String id) async {
    final ref =
        FirebaseDatabase.instance.ref('books/${_auth.currentUser!.uid}/$id');
    final snapshot = await ref.get();

    if (snapshot.exists) {
      return Book.fromJson(snapshot.value);
    }

    return null;
  }
}
