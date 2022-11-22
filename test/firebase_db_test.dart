import 'package:books_app/controllers/firebase_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database_mocks/firebase_database_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FirebaseDatabase firebaseDatabase;
  FirebaseAuth firebaseAuth;
  MockUser mockUser;
  FirebaseDBHelper? firebaseDBHelper;
  const fakeData = {
    'books': {
      '123': {
        '-bF2CwAAQBAJ': {
          'authors': "J.K. Rowling",
          'averageRating': 5,
          'categories': "Juvenile Fiction",
          'description':
              "Quando Harry Potter é deixado em uma porta ainda bebê, ele não faz ideia de que é o Menino Que Sobreviveu, ou de que é famoso em todo o mundo bruxo. Anos depois, ele fica surpreso ao receber uma carta de admissão da Escola de Magia e Bruxaria de Hogwarts e é rapidamente levado em uma aventura mágica como nenhuma outra. Junte-se a Harry e seus amigos leais, Hermione e Ron, nesta história sobre o poder da verdade, amor e esperança. Clássicos do nosso tempo, os ebooks de Harry Potter nunca deixam de oferecer conforto e escapismo. Com sua mensagem de esperança, pertencimento e o poder duradouro da verdade e do amor, a história do Menino Que Sobreviveu continua a encantar gerações de novos leitores.",
          'id': "-bF2CwAAQBAJ",
          'imageUrl':
              "http'://books.google.com/books/content?id=-bF2CwAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
          'pageCount': 4181,
          'publishedDate': "2016-01-28",
          'publisher': "Pottermore Publishing",
          'state': "read",
          'title': "Harry Potter: A Coleção Completa (1-7)"
        }
      }
    }
  };
  MockFirebaseDatabase.instance.ref().set(fakeData);
  setUp(() {
    mockUser = MockUser(
      uid: '123',
      email: 'mocked-email',
      displayName: 'mocked-display-name',
    );
    firebaseAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
    firebaseDatabase = MockFirebaseDatabase.instance;
    firebaseDBHelper = FirebaseDBHelper(firebaseAuth, firebaseDatabase);
  });

  test("should be able to get all books", () async {
    final books = await firebaseDBHelper?.getAllBooks();

    expect(books?.length, 1);
    expect(books?[0].id, "-bF2CwAAQBAJ");
    expect(books?[0].title, "Harry Potter: A Coleção Completa (1-7)");
  });

  test("should be able to find book by id", () async {
    final book = await firebaseDBHelper?.getBookById("-bF2CwAAQBAJ");

    expect(book?.id, "-bF2CwAAQBAJ");
    expect(book?.title, "Harry Potter: A Coleção Completa (1-7)");
  });
}
