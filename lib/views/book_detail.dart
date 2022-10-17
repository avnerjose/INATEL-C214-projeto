import 'dart:ui';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(book.imageUrl),
                          fit: BoxFit.cover)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.1)),
                    ),
                  ),
                ),
                Positioned(
                    top: 8,
                    left: 8,
                    child: SizedBox(
                        height: 38,
                        width: 38,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            padding: EdgeInsets.zero,
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.chevron_left),
                        )))
              ]),
              Container(
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
                        const SizedBox(height: 130),
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
                            onPressed: () {},
                            child: const Text("Adicionar aos livros lidos",
                                style: TextStyle(color: Colors.white))),
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.double,
                                ),
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          child: const Text("Adicionar à lista de desejos"),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: const BoxDecoration(
                              border: Border(
                                  top: BorderSide(color: AppColors.lightGray))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      book.pageCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.lightGray),
                                    ),
                                    const Text("Páginas",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.lightGray))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Publicado em:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.lightGray)),
                                    Text(book.publishedDate,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.lightGray)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text("Nota média:",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.lightGray)),
                                    Text('${book.averageRating}/5.0',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.lightGray)),
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
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                color: AppColors.dark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Descrição",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      book.description,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                color: AppColors.dark,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Outras informações",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                    const SizedBox(height: 8),
                    Text(
                      '\u2022 Editora: ${book.publisher}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      '\u2022 Categorias: ${book.categories.join(',')}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
