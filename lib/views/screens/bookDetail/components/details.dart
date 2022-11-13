import 'package:books_app/core/app_colors.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Book book;
  final AsyncCallback handleAddToAlreadyRead;
  final AsyncCallback handleRemoveFromAlreadyRead;
  final AsyncCallback handleAddToWishlist;
  final AsyncCallback handleRemoveFromWishlist;

  const Details(
      {Key? key,
      required this.book,
      required this.handleAddToAlreadyRead,
      required this.handleRemoveFromAlreadyRead,
      required this.handleAddToWishlist,
      required this.handleRemoveFromWishlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.dark,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: const Offset(0, -150),
            child: Image.network(
              book.imageUrl,
              height: 192,
              width: 128,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 150),
              Text(
                book.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(book.authors.join(', '),
                  style: const TextStyle(
                      color: AppColors.lightGray, fontSize: 14)),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () async {
                    if (book.state != BookState.read) {
                      await handleAddToAlreadyRead();
                    } else if (book.state == BookState.read) {
                      await handleRemoveFromAlreadyRead();
                    }
                  },
                  child: Text(
                      book.state != BookState.read
                          ? "Adicionar aos livros lidos"
                          : "Remover dos livros lidos",
                      style: const TextStyle(color: Colors.white))),
              if (book.state == BookState.none ||
                  book.state == BookState.wishlist)
                TextButton(
                  onPressed: () async {
                    if (book.state == BookState.none) {
                      await handleAddToWishlist();
                    } else if (book.state == BookState.wishlist) {
                      await handleRemoveFromWishlist();
                    }
                  },
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.double,
                        ),
                      ),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  child: Text(book.state == BookState.none
                      ? "Adicionar à lista de desejos"
                      : "Remover da lista de desejos"),
                ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(color: AppColors.lightGray))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            book.pageCount.toString(),
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.lightGray),
                          ),
                          const Text("Páginas",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.lightGray))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Publicado em:",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.lightGray)),
                          Text(book.publishedDate,
                              style: const TextStyle(
                                  fontSize: 14, color: AppColors.lightGray)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text("Nota média:",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.lightGray)),
                          Text('${book.averageRating}/5.0',
                              style: const TextStyle(
                                  fontSize: 14, color: AppColors.lightGray)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
