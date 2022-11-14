enum BookState {
  none,
  read,
  wishlist;

  @override
  String toString() {
    switch (this) {
      case BookState.none:
        return 'none';
      case BookState.read:
        return 'read';
      case BookState.wishlist:
        return 'wishlist';
    }
  }

  static BookState fromString(String state) {
    switch (state) {
      case 'none':
        return BookState.none;
      case 'read':
        return BookState.read;
      case 'wishlist':
        return BookState.wishlist;
    }

    return BookState.none;
  }
}

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
  BookState state;

  Book(
      {required this.id,
      required this.title,
      required this.authors,
      required this.publisher,
      required this.publishedDate,
      required this.description,
      required this.pageCount,
      required this.categories,
      required this.averageRating,
      required this.imageUrl,
      this.state = BookState.none});

  factory Book.fromJson(dynamic json) {
    return Book(
        id: json['id'],
        title: json['title'],
        authors: json['authors'].split(' '),
        publisher: json['publisher'],
        publishedDate: json['publishedDate'],
        description: json['description'],
        pageCount: json['pageCount'],
        averageRating: json['averageRating'].toDouble(),
        categories:
            json['categories'] != null ? json['categories'].split(' ') : [],
        imageUrl: json['imageUrl'],
        state: json['state'] != null
            ? BookState.fromString(json['state'])
            : BookState.none);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'authors': authors.join(' '),
        'publisher': publisher,
        'publishedDate': publishedDate,
        'description': description,
        'pageCount': pageCount,
        'averageRating': averageRating,
        'categories': categories.join(' '),
        'imageUrl': imageUrl,
        'state': state.toString()
      };

  static List<Book> booksFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Book.fromJson(data);
    }).toList();
  }
}
