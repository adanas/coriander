
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPage extends StatelessWidget { // 画面はStatelessWidget
    NextPage(this.name); // コンストラクタ的な
    final String name;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Next Page'),
        ),
        body: Container(
          color: Colors.red,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(name),
              Center(
                child: RaisedButton(
                  child: Text('戻る'),
                  onPressed: (){
                    // ここに押した後の動きを書く
                    Navigator.pop(context, 'sanadax'); // pop:戻る
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
}