import 'package:books_app/controllers/firebase_auth.dart';
import 'package:books_app/core/app_colors.dart';
import 'package:books_app/views/screens/bookSearch/book_search_screen.dart';
import 'package:books_app/views/screens/editProfile/edit_profile_screen.dart';
import 'package:books_app/views/screens/login/login_screen.dart';
import 'package:books_app/views/screens/userBookshelf/user_bookshelf.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> pages = [
    const BookSearchScreen(),
    const UserBookshelfScreen(),
  ];
  late User? user = null;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          this.user = user;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        backgroundColor: AppColors.background,
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.green,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePicture(
                        name: user?.displayName ?? "",
                        img: user?.photoURL,
                        radius: 31,
                        fontsize: 21),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      user?.displayName ?? "",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      user?.email ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                )),
            ListTile(
                iconColor: AppColors.lightGray,
                leading: const Icon(Icons.person),
                title: const Text("Editar perfil",
                    style: TextStyle(color: AppColors.lightGray, fontSize: 16)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileScreen()));
                }),
            ListTile(
              iconColor: AppColors.lightGray,
              leading: const Icon(Icons.logout),
              title: const Text("Sair",
                  style: TextStyle(color: AppColors.lightGray, fontSize: 16)),
              onTap: () async {
                await FirebaseAuthHelper(FirebaseAuth.instance).signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
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
