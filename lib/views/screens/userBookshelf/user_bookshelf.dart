import 'package:books_app/core/app_colors.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/views/widgets/book_list_item.dart';
import 'package:flutter/material.dart';

class UserBookshelfScreen extends StatelessWidget {
  UserBookshelfScreen({Key? key}) : super(key: key);

  final Book _book = Book(
      id: "Id",
      title: "Harry Potter e o cálice de fogo e alguma coisa muito louca",
      authors: ['Jk Rowling'],
      publisher: 'Rocco',
      publishedDate: "2009",
      description:
          "losfasd ajsdl fjaldsjf lajsdfklja sdlfkjasldk jfalsatydj flajsdklfa",
      pageCount: 200,
      categories: ['Fanstasy'],
      averageRating: 4,
      imageUrl:
          "https://books.google.com/books/content?id=yjUQCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.dark,
        title: const Text(
          'Sua estante',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(children: [
          BookListItem(
              title: _book.title,
              authors: _book.authors,
              imageUrl: _book.imageUrl,
              averageRating: _book.averageRating),
          const SizedBox(height: 8),
          BookListItem(
              title: _book.title,
              authors: _book.authors,
              imageUrl: _book.imageUrl,
              averageRating: _book.averageRating)
        ]),
      ),
    );
  }
}
