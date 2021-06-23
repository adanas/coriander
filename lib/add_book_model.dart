import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'book.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  // 追加
  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw('空です。タイトルを入力してください');
    }

    final imageURL = await uploadImage();

    Firestore.instance.collection('books').add(
        {
          'title': bookTitle,
          'imageURL': imageURL,
          'createdAt':Timestamp.now(),
        },
    );
  }
  // 更新
  Future updateBook(Book book) async {
    final document = Firestore.instance.collection('books').document(book.documentId);
    final imageURL = await uploadImage();

    await document.updateData({
      'title': bookTitle,
      'imageURL': imageURL,
      'updateAt':Timestamp.now(),
    }
    );
  }

  Future<String> uploadImage() async {
    // Storageへアップロード
    final storage = FirebaseStorage.instance;
    StorageTaskSnapshot snapshot = await storage.ref().child("books/$bookTitle").putFile(imageFile).onComplete;

    final String downloadURL = await snapshot.ref.getDownloadURL();

    return downloadURL;
  }

  // カメラロール開く
  Future showImagePicker() async {
    final picker = ImagePicker();

    // 画像を選択
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);

    // 選択した画像を通知
    notifyListeners();
  }
}