import 'dart:ui';
import 'package:books_app/controllers/firebase_db.dart';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/views/screens/bookDetail/components/background_image.dart';
import 'package:books_app/views/screens/bookDetail/components/description.dart';
import 'package:books_app/views/screens/bookDetail/components/details.dart';
import 'package:books_app/views/screens/bookDetail/components/other_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState(book: book);
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  _BookDetailScreenState({required this.book});
  Book book;

  Future<void> handleAddToAlreadyRead() async {
    final isBookOnDb =
        await FirebaseDBHelper(FirebaseAuth.instance, FirebaseDatabase.instance)
                .getBookById(book.id) !=
            null;

    setState(() {
      book.state = BookState.read;
    });

    if (isBookOnDb) {
      await FirebaseDBHelper(FirebaseAuth.instance, FirebaseDatabase.instance)
          .updateBook(book);
    } else {
      await FirebaseDBHelper(FirebaseAuth.instance, FirebaseDatabase.instance)
          .storeBook(book);
    }
  }

  Future<void> handleRemoveFromAlreadyRead() async {
    setState(() {
      book.state = BookState.none;
    });

    await FirebaseDBHelper(FirebaseAuth.instance, FirebaseDatabase.instance)
        .deleteBook(book.id);
  }

  Future<void> handleAddToWishlist() async {
    setState(() {
      book.state = BookState.wishlist;
    });

    await FirebaseDBHelper(FirebaseAuth.instance, FirebaseDatabase.instance)
        .storeBook(book);
  }

  Future<void> handleRemoveFromWishlist() async {
    setState(() {
      book.state = BookState.none;
    });

    await FirebaseDBHelper(FirebaseAuth.instance, FirebaseDatabase.instance)
        .deleteBook(book.id);
  }

  @override
  void initState() {
    FirebaseDBHelper(FirebaseAuth.instance, FirebaseDatabase.instance)
        .getBookById(book.id)
        .then((value) {
      if (value != null) {
        setState(() {
          book = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              BackgroundImage(imageUrl: book.imageUrl),
              Details(
                  book: book,
                  handleAddToAlreadyRead: handleAddToAlreadyRead,
                  handleRemoveFromAlreadyRead: handleRemoveFromAlreadyRead,
                  handleAddToWishlist: handleAddToWishlist,
                  handleRemoveFromWishlist: handleRemoveFromWishlist),
              const SizedBox(height: 16),
              Description(description: widget.book.description),
              const SizedBox(height: 16),
              OtherInfo(
                  publisher: widget.book.publisher,
                  categories: widget.book.categories.join(','))
            ],
          ),
        )));
  }
}
