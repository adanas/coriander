import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_book_model.dart';
import 'book.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {

    final bool isUpdate = book != null; // 本を編集かどうか

    final textEditingController = TextEditingController();
    if (isUpdate) {
      textEditingController.text = book.title;
    }


    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? '本を編集' : '本を追加'),
        ),
        body: Consumer<AddBookModel>(
            builder: (context, model, child) {
              return Column(children: <Widget>[
                TextField(
                  controller: textEditingController,
                  onChanged: (text){
                    model.bookTitle = text;
                    TextField(

                    );
                  },
                ),
                ElevatedButton(
                  child: Text(isUpdate ? '更新する' : '追加する'),
                  onPressed: () async {
                    if (isUpdate) {
                      await updateBook(model, context);
                    }
                    else {
                      await addBook(model, context);
                    }

                  },
                )
              ],
              );
            }
        ),

      ),
    );
  }

  Future addBook(AddBookModel model, BuildContext context) async {
    try {
      //firestoreに本を追加
      await model.addBookToFirebase();

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:Text('追加したよ'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // 追加成功したら元画面へ戻る
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:Text(e.toString()),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future updateBook(AddBookModel model, BuildContext context) async {
    try {
      //firestoreの本を編集
      await model.updateBook(book);

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:Text('更新したよ'),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      // 追加成功したら元画面へ戻る
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title:Text(e.toString()),
            actions: <Widget>[
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

}