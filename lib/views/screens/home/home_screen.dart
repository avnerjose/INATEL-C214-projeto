import 'package:books_app/core/app_colors.dart';
import 'package:books_app/views/screens/bookSearch/book_search_screen.dart';
import 'package:books_app/views/screens/userBookshelf/user_bookshelf.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> pages = [
    BookSearchScreen(),
    UserBookshelfScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.dark,
        unselectedItemColor: AppColors.lightGray,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Busca'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_rounded), label: 'Sua estante')
        ],
      ),
    );
  }
}
