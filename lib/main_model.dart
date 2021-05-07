import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  String topText = 'コリアンダー！';

  void changeTopText(){
    topText = 'パクチー最高！';
    notifyListeners();
  }


}