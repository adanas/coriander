import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';

  // 追加
  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw('空です。タイトルを入力してください');
    }
    Firestore.instance.collection('books').add(
        {
          'title': bookTitle,
        },
    );
  }
  // 編集
  Future updateBook(Book book) async {
    final document = Firestore.instance.collection('books').document(book.documentId);

    await document.updateData({
      'title': bookTitle,
    }
    );
  }
}