import 'package:books_app/models/book.dart';
import 'package:books_app/views/widgets/book_list_item.dart';
import 'package:flutter/material.dart';

class BooksList extends StatelessWidget {
  final List<Book> books;

  const BooksList({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return BookListItem(
              id: books[index].id,
              authors: books[index].authors,
              title: books[index].title,
              imageUrl: books[index].imageUrl,
              averageRating: books[index].averageRating,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: books.length),
    );
  }
}
