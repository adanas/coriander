import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  String topText = 'コリアンダー！';

  void changeTopText(){
    topText = '最高パクチー最高！';
    notifyListeners();
  }


}