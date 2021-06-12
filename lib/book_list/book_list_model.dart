import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/book.dart';
import 'package:flutter/cupertino.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetchBooks() async {
    final docs = await Firestore.instance.collection('books').getDocuments();

    // docs → booksに変換
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
    notifyListeners();

  }

  // 削除処理
  Future deleteBook(Book book) async {
    await Firestore.instance.collection('books').document(book.documentId).delete();
  }

}