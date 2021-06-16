import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 追加
  Future signUp() async {
    if(mail.isEmpty) {
      throw('please input email');
    }
    if(password.isEmpty) {
      throw('please input password');
    }

    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    )).user;

    final email = user.email;

    Firestore.instance.collection('users').add(
      {
        'email':email,
        'createAt':Timestamp.now(),
      }
    );

  }
}