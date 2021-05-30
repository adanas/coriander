import 'package:coriander/book_list/book_list_page.dart';
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
        child: Scaffold(
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
                    Text(
                      model.topText,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    ElevatedButton(
                      child: Text('ボタン'),
                      onPressed: () {
                        // modelのメソッドをcall
                        //model.changeTopText();

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BookListPage()),
                        );

                      },
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}