class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final int pageCount;
  final List<String> categories;
  final double averageRating;
  final String imageUrl;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.averageRating,
    required this.imageUrl,
  });

  factory Book.fromJson(dynamic json) {
    var bookInfo = json['volumeInfo'];
    return Book(
        id: json['id'],
        title: bookInfo['title'],
        authors: List<String>.from(bookInfo['authors']),
        publisher: bookInfo['publisher'] ?? "Unknown",
        publishedDate: bookInfo['publishedDate'] ?? "",
        description: bookInfo['description'],
        pageCount: bookInfo['pageCount'],
        averageRating: bookInfo['averageRating'] != null
            ? bookInfo['averageRating'].toDouble()
            : 0.0,
        categories: bookInfo['categories'] != null
            ? List<String>.from(bookInfo['categories'])
            : [],
        imageUrl: bookInfo['imageLinks']['thumbnail']);
  }

  static List<Book> booksFromSnapshot(List snapshot) {
    return snapshot.where((element) {
      var validation = element['volumeInfo']['imageLinks'] != null &&
          element['volumeInfo']['imageLinks']['thumbnail'] != null &&
          element['volumeInfo']['description'] != null &&
          element['volumeInfo']['pageCount'] != null;
      return validation;
    }).map((data) {
      return Book.fromJson(data);
    }).toList();
  }
}
