import 'dart:async';

import 'package:books_app/controllers/books_api.dart';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/views/screens/bookDetail/book_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({Key? key}) : super(key: key);

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  late List<Book> _books = [];
  final textEditingController = TextEditingController();
  bool isLoading = false;
  Timer? timeHandle;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(_getBooks);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _getBooks() async {
    if (textEditingController.text.trim() != "") {
      var query = textEditingController.text.split(' ').join("+");

      if (mounted) {
        if (timeHandle != null) {
          timeHandle?.cancel();
        }

        timeHandle = Timer(const Duration(seconds: 1), () async {
          setState(() {
            isLoading = true;
          });
          final booksAPI = BooksAPI(client: http.Client());
          var books = await booksAPI.fetchBooksBySearch(query);
          setState(() {
            _books = books;
            isLoading = false;
          });
        });
      }
    } else {
      setState(() {
        _books = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColors.dark,
          elevation: 0,
          title: const Text("Lista de livros",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: AppColors.dark),
        ),
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.dark,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: textEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: AppColors.background,
                        hintText: "Pesquise um livro",
                        hintStyle: TextStyle(color: AppColors.lightGray),
                        icon: Icon(Icons.search),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.count(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.667,
                        children: List.generate(
                            _books.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BookDetailScreen(
                                                    book: _books[index])));
                                  },
                                  child: Image.network(
                                    _books[index].imageUrl,
                                  ),
                                )),
                      ),
              ),
            ],
          ),
        ));
  }
}
