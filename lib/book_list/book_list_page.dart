import 'package:coriander/add_book_page.dart';
import 'package:coriander/book_list/book_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../book.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本棚'),
        ),
        body: Consumer<BookListModel>(
            builder: (context, model, child) {
              final books = model.books;
              final listTiles = books
                  .map(
                      (book) => ListTile(
                        leading: Image.network(book.imageURL),
                        title: Text(book.title),
                        trailing: IconButton(
                            icon: Icon(Icons.edit),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddBookPage(
                                  book: book,
                                ),
                                fullscreenDialog: true,
                              ),
                            );
                            model.fetchBooks();
                          },
                        ),
                        onLongPress: () async {
                          await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                            return AlertDialog(
                              title:Text('${book.title} を削除しますか？'),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text('OK'),
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    // 削除処理
                                    await deleteBook(context, model, book);
                                  },
                                ),
                              ],
                            );
                          },
                          );
                        },
                      ),
                  )
              .toList();
              return ListView(
                children: listTiles,
            );
          }
        ),

        // 本を追加ボタン
        floatingActionButton: Consumer<BookListModel>(builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddBookPage(),
                      fullscreenDialog: true,
                  ),
                );
                model.fetchBooks();
              },
            );
          }
        ),
      ),
    );
  }
}

Future deleteBook(BuildContext context, BookListModel model, Book book) async {
  try {
    await model.deleteBook(book); // 削除処理
    await model.fetchBooks();     // 画面更新
    print('delete ${book.title}');
  } catch (e) {
    await _showDialog(context, e.toString());
    print(e.toString());
  }
}

Future<void> _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title:Text(title),
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

    return null;
  }
