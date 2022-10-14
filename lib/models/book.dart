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
        authors: bookInfo['authors'],
        publisher: bookInfo['publisher'],
        publishedDate: bookInfo['publishedDate'],
        description: bookInfo['description'],
        pageCount: bookInfo['pageCount'],
        averageRating: bookInfo['averageRating'],
        categories: bookInfo['categories'],
        imageUrl: bookInfo['imageLinks']['thumbnail']);
  }

  static List<Book> booksFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Book.fromJson(data);
    }).toList();
  }
}

// {
// 	"kind": "books#volumes",
// 	"totalItems": 971,
// 	"items": [
// 		{
// 			"kind": "books#volume",
// 			"id": "GgQmDwAAQBAJ",
// 			"etag": "UUNHG9vaQu4",
// 			"selfLink": "https://www.googleapis.com/books/v1/volumes/GgQmDwAAQBAJ",
// 			"volumeInfo": {
// 				"title": "O universo de Harry Potter de A a Z",
// 				"authors": [
// 					"Aubrey Malone"
// 				],
// 				"publisher": "HarperCollins Brasil",
// 				"publishedDate": "2014-02-27",
// 				"description": "Uma geração de crianças do mundo inteiro embarcou no Expresso de Hogwarts em direção a um mundo mágico cheio de criaturas incríveis, feitiços poderosos e aventuras inesquecíveis. Por anos, jovens atravessaram a plataforma 9 3⁄4 da estação King's Cross e criaram memórias extraordinárias na companhia de Harry, Rony e Hermione. Todo fã de Harry Potter gostaria de ter uma penseira para refrescar a mente e relembrar cada personagem, lugar ou criatura fantástica que aparece nas páginas escritas por J.K Rowling. Mas como se lembrar do nome dos feitiços e das maldições imperdoáveis? Ou das plantas da aula de Herbologia da senhora Sprout? Ou ainda dos lugares visitados com a ajuda do Mapa do Maroto? O universo de Harry Potter de A a Z permite reviver as recordações que marcaram a infância de muita gente, trazendo ainda curiosidades sobre a vida de J.K Rowling, o incrível sucesso da série, os filmes e seus atores. Inclui verbertes sobre todos os livros da série",
// 				"industryIdentifiers": [
// 					{
// 						"type": "ISBN_13",
// 						"identifier": "9788595081437"
// 					},
// 					{
// 						"type": "ISBN_10",
// 						"identifier": "8595081433"
// 					}
// 				],
// 				"readingModes": {
// 					"text": true,
// 					"image": true
// 				},
// 				"pageCount": 160,
// 				"printType": "BOOK",
// 				"categories": [
// 					"Juvenile Fiction"
// 				],
// 				"averageRating": 4.5,
// 				"ratingsCount": 2,
// 				"maturityRating": "NOT_MATURE",
// 				"allowAnonLogging": true,
// 				"contentVersion": "1.22.23.0.preview.3",
// 				"panelizationSummary": {
// 					"containsEpubBubbles": false,
// 					"containsImageBubbles": false
// 				},
// 				"imageLinks": {
// 					"smallThumbnail": "http://books.google.com/books/content?id=GgQmDwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
// 					"thumbnail": "http://books.google.com/books/content?id=GgQmDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
// 				},
// 				"language": "pt-BR",
// 				"previewLink": "http://books.google.com.br/books?id=GgQmDwAAQBAJ&printsec=frontcover&dq=harry&hl=&cd=1&source=gbs_api",
// 				"infoLink": "https://play.google.com/store/books/details?id=GgQmDwAAQBAJ&source=gbs_api",
// 				"canonicalVolumeLink": "https://play.google.com/store/books/details?id=GgQmDwAAQBAJ"
// 			},
// 			"saleInfo": {
// 				"country": "BR",
// 				"saleability": "FOR_SALE",
// 				"isEbook": true,
// 				"listPrice": {
// 					"amount": 14.9,
// 					"currencyCode": "BRL"
// 				},
// 				"retailPrice": {
// 					"amount": 14.16,
// 					"currencyCode": "BRL"
// 				},
// 				"buyLink": "https://play.google.com/store/books/details?id=GgQmDwAAQBAJ&rdid=book-GgQmDwAAQBAJ&rdot=1&source=gbs_api",
// 				"offers": [
// 					{
// 						"finskyOfferType": 1,
// 						"listPrice": {
// 							"amountInMicros": 14900000,
// 							"currencyCode": "BRL"
// 						},
// 						"retailPrice": {
// 							"amountInMicros": 14160000,
// 							"currencyCode": "BRL"
// 						},
// 						"giftable": true
// 					}
// 				]
// 			},
// 		
// 		}
// 	]
// }