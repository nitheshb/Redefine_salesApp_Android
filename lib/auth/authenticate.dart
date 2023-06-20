import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../startup.dart';
import 'LoginPage.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const startUpPage();
    } else {
      return const LoginPage();
    }
  }
}
