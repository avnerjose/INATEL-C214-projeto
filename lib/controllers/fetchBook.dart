import 'dart:convert';
import 'package:books_app/models/book.dart';
import 'package:http/http.dart' as http;

Future<List<Book>> fetchBooksBySearch(String query) async {
  final res = await http.get(Uri.parse(
      'https://www.googleapis.com/books/v1/volumes?q=$query'));
  Map data = jsonDecode(res.body);
  List items = data['items'];

  if (res.statusCode == 200) {
    return Book.booksFromSnapshot(items);
  } else {
    throw Exception('Failed to load books');
  }
}
