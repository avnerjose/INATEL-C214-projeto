import 'dart:ui';

import 'package:books_app/core/app_colors.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Book _book = Book(
        id: "1",
        authors: ['Jk Rowling'],
        averageRating: 4,
        categories: ['Fantasy'],
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pellentesque fringilla lorem, nec fermentum lectus rutrum mattis. Etiam placerat, est eu sollicitudin molestie, turpis nibh elementum augue, nec volutpat lacus augue vitae velit. Quisque ac sapien aliquam, gravida turpis vel, tempus ligula. Mauris sed lobortis nisi. Duis dapibus cursus semper. Ut eget aliquet risus, sed interdum diam. Nunc tincidunt est sit amet magna mattis convallis. Praesent sit amet porttitor dui. Aenean interdum neque urna, et pretium ligula tempor quis. Curabitur tincidunt purus a erat hendrerit laoreet.",
        imageUrl:
            "http://books.google.com/books/content?id=wmy674GblEUC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
        pageCount: 200,
        publishedDate: "2001",
        publisher: "Rocco",
        title: "Harry Potter e o cálice de fogo");

    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(_book.imageUrl),
                        fit: BoxFit.cover)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.1)),
                  ),
                ),
              ),
              Container(
                color: AppColors.dark,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -150),
                      child: Image.network(
                        _book.imageUrl,
                        height: 192,
                        width: 128,
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 120),
                        Text(
                          _book.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ..._book.authors.map((author) => Text(author,
                                style: const TextStyle(
                                    color: AppColors.lightGray, fontSize: 14)))
                          ],
                        ),
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
                                      _book.pageCount.toString(),
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
                                    Text(_book.publishedDate,
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
                                    Text('${_book.averageRating}/5',
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
                      _book.description,
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
                      '\u2022 Editora: ${_book.publisher}',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      '\u2022 Categorias: ${_book.categories.join(',')}',
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
