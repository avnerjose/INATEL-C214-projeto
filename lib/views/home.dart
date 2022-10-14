import 'package:books_app/controllers/fetchBook.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Book> _books = [];
  final textEditingController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(_getBooks);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    ;
  }

  Future<void> _getBooks() async {
    if (textEditingController.text.trim() != "") {
      setState(() {
        isLoading = true;
      });
      var query = textEditingController.text.split(' ').join("+");
      _books = await fetchBooksBySearch(query);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(243, 245, 246, 1),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.4),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(
                      2.0,
                      2.0,
                    ),
                  )
                ]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Lista de livros",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                          hintText: "Pesquise um livro",
                          icon: Icon(Icons.search)),
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
                            (index) => Image.network(
                                  _books[index].imageUrl,
                                )),
                      ),
              ),
            ],
          ),
        ));
  }
}
