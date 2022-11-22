import 'dart:convert';
import 'dart:io';

import 'package:books_app/controllers/books_api.dart';
import 'package:books_app/models/book.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'books_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("fetchBooksBySearch", () {
    test('should be able to return a list of books', () async {
      final mockedJson =
          await File('test/mocks/book_response.json').readAsString();
      final query = 'harry potter'.split(' ').join("+");
      final client = MockClient();
      final booksApi = BooksAPI(client: client);
      when(client.get(Uri.parse(
              '${BooksAPI.apiEndpoint}?q=$query&key=AIzaSyDggkm2pDO3txK4ZwMmPgpOQWvxyc6U4cw')))
          .thenAnswer((_) async => http.Response(mockedJson.toString(), 200));
      final res = await booksApi.fetchBooksBySearch(query);
      final mockedBook = Book.fromJson(BooksAPI.handleApiBookMapConversion(
          jsonDecode(mockedJson)['items'][0]));

      expect(res, isA<List<Book>>());
      expect(res[0].id, mockedBook.id);
      expect(res[0].title, mockedBook.title);
      expect(res[0].authors, mockedBook.authors);
      expect(res[0].publisher, mockedBook.publisher);
      expect(res[0].publishedDate, mockedBook.publishedDate);
      expect(res[0].description, mockedBook.description);
      expect(res[0].pageCount, mockedBook.pageCount);
      expect(res[0].averageRating, mockedBook.averageRating);
      expect(res[0].categories, mockedBook.categories);
      expect(res[0].imageUrl, mockedBook.imageUrl);
    });

    test("should throw error if status code different from 200", () async {
      final query = 'harry pitter'.split(' ').join("+");
      final client = MockClient();
      final booksApi = BooksAPI(client: client);
      when(client.get(Uri.parse(
              '${BooksAPI.apiEndpoint}?q=$query&key=AIzaSyDggkm2pDO3txK4ZwMmPgpOQWvxyc6U4cw')))
          .thenAnswer((_) async => http.Response('Not found', 404));
      expect(booksApi.fetchBooksBySearch(query), throwsException);
    });
  });

  group("handleApiBookMapConversion", () {
    test("should be able to convert a book from api to a book model", () async {
      final mockedJson =
          await File('test/mocks/book_response.json').readAsString();
      final apiBookJson = jsonDecode(mockedJson)['items'][0];
      final convertedBookMap = BooksAPI.handleApiBookMapConversion(apiBookJson);
      final mockedBook = Book.fromJson(convertedBookMap);

      expect(convertedBookMap, isA<Map<String, dynamic>>());
      expect(convertedBookMap['id'], mockedBook.id);
      expect(convertedBookMap['title'], mockedBook.title);
      expect(convertedBookMap['authors'], mockedBook.authors.join(" "));
      expect(convertedBookMap['publisher'], mockedBook.publisher);
      expect(convertedBookMap['publishedDate'], mockedBook.publishedDate);
      expect(convertedBookMap['description'], mockedBook.description);
      expect(convertedBookMap['pageCount'], mockedBook.pageCount);
      expect(convertedBookMap['averageRating'], mockedBook.averageRating);
      expect(convertedBookMap['categories'], mockedBook.categories.join(" "));
      expect(convertedBookMap['imageUrl'], mockedBook.imageUrl);
    });
  });

  group("filter api books", () {
    test("should be able to filter books", () async {
      final mockedJson =
          await File('test/mocks/book_response.json').readAsString();
      final apiBooksJson = jsonDecode(mockedJson)['items'] as List;
      final filteredBooks = BooksAPI.filterApiBooks(apiBooksJson);

      expect(filteredBooks.length, 1);
    });
  });
}
