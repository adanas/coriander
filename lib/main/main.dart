//import 'package:coriander/book_list/book_list_page.dart';
import 'package:coriander/add_book_model.dart';
import 'package:coriander/book_list/book_list_page.dart';
import 'package:coriander/login/login_page.dart';
import 'package:coriander/signup/signup_page.dart';
// import 'package:coriander/next_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Stack(
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                title: Text('Hello Flutter App Test'),
                //backgroundColor: Colors.black12,
                //actions: [],
              ),
              // notifyListenersを受けてConsumerが発火する
              body: Consumer<MainModel>(builder: (context, model, child) {
                  return Center(
                    child: Column(
                      children: [
                        // テキスト
                        Text(
                          model.topText,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        // 本一覧ボタン
                        ElevatedButton(
                          child: Text('Book List'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => BookListPage()),
                            );

                          },
                        ),
                        // 新規登録ボタン
                        ElevatedButton(
                          child: Text('新規登録'),
                          onPressed: () {
                            // modelのメソッドをcall
                            //model.changeTopText();

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpPage()),
                            );

                          },
                        ),
                        // ログインボタン
                        ElevatedButton(
                          child: Text('ログイン'),
                          onPressed: () {
                            // modelのメソッドをcall
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );

                          },
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
            // Consumer<AddBookModel>(builder: (context, model, child) {
            //     return model.isLoading
            //         ? Container(
            //           color: Colors.grey.withOpacity(0.7),
            //           child: Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         ) : SizedBox();
            //   }
            // ),
          ],
        ),
      ),
    );

  }
}