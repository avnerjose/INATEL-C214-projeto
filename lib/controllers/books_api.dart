import 'dart:convert';
import 'package:books_app/models/book.dart';
import 'package:http/http.dart' as http;

class BooksAPI {
  static const String _apiEndpoint =
      "https://www.googleapis.com/books/v1/volumes";

  static Future<List<Book>> fetchBooksBySearch(String query) async {
    final res = await http.get(Uri.parse('$_apiEndpoint?q=$query&key=AIzaSyDggkm2pDO3txK4ZwMmPgpOQWvxyc6U4cw'));
    Map data = jsonDecode(res.body);
    List items = data['items'];
    List convertedItems = filterApiBooks(items)
        .map((item) => handleApiBookMapConversion(item))
        .toList();

    if (res.statusCode == 200) {
      return Book.booksFromSnapshot(convertedItems);
    } else {
      throw Exception('Failed to load books');
    }
  }

  static Map<String, dynamic> handleApiBookMapConversion(dynamic apiBookJson) {
    var bookInfo = apiBookJson['volumeInfo'];

    Map<String, dynamic> convertedBookMap = {};

    convertedBookMap['id'] = apiBookJson['id'];
    convertedBookMap['title'] = bookInfo['title'];
    convertedBookMap['authors'] = bookInfo['authors'] != null
        ? List<String>.from(bookInfo['authors']).join(' ')
        : ' ';
    convertedBookMap['publisher'] = bookInfo['publisher'] ?? "Unknown";
    convertedBookMap['publishedDate'] = bookInfo['publishedDate'];
    convertedBookMap['description'] = bookInfo['description'];
    convertedBookMap['pageCount'] = bookInfo['pageCount'];
    convertedBookMap['averageRating'] = bookInfo['averageRating'].toDouble();
    convertedBookMap['categories'] = bookInfo['categories'] != null
        ? List<String>.from(bookInfo['categories']).join(' ')
        : '';
    convertedBookMap['imageUrl'] = bookInfo['imageLinks']['thumbnail'];

    return convertedBookMap;
  }

  static List filterApiBooks(List apiBooks) {
    return apiBooks.where((element) {
      var validation = element['volumeInfo']['imageLinks'] != null &&
          element['volumeInfo']['imageLinks']['thumbnail'] != null &&
          element['volumeInfo']['description'] != null &&
          element['volumeInfo']['pageCount'] != null &&
          element['volumeInfo']['averageRating'] != null &&
          element['volumeInfo']['publishedDate'] != null;
      return validation;
    }).toList();
  }
}
