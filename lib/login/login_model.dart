import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 追加
  Future login() async {
    if(mail.isEmpty) {
      throw('please input email');
    }
    if(password.isEmpty) {
      throw('please input password');
    }

    try {
      final result = await _auth.signInWithEmailAndPassword(email: mail, password: password);
      final uid = result.user.uid;

      // todo 端末に保存

    } catch(e) {
      throw('login failed');
    }

  }
}