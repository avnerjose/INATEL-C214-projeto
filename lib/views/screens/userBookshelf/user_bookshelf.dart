import 'package:books_app/controllers/firebase_db.dart';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/views/screens/userBookshelf/components/books_list.dart';
import 'package:books_app/views/widgets/book_list_item.dart';
import 'package:flutter/material.dart';

class UserBookshelfScreen extends StatefulWidget {
  UserBookshelfScreen({Key? key}) : super(key: key);

  @override
  State<UserBookshelfScreen> createState() => _UserBookshelfScreenState();
}

class _UserBookshelfScreenState extends State<UserBookshelfScreen> {
  List<Book> alreadyReadBooks = [];
  List<Book> wishListBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    FirebaseDBHelper().getAllBooks().then((e) => {
          setState(() {
            alreadyReadBooks =
                e.where((e) => e.state == BookState.read).toList();
            wishListBooks =
                e.where((e) => e.state == BookState.wishlist).toList();
          })
        });
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.dark,
            title: const Text(
              'Sua estante',
              style: TextStyle(color: Colors.white),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Livros lidos",
                ),
                Tab(
                  text: "Lista de desejos",
                )
              ],
            ),
          ),
          backgroundColor: AppColors.background,
          body: TabBarView(
            children: [
              isLoading
                  ? const Center(
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator()),
                    )
                  : BooksList(books: alreadyReadBooks),
              isLoading
                  ? const Center(
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator()),
                    )
                  : BooksList(books: wishListBooks)
            ],
          )),
    );
  }
}
