import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class data extends StatefulWidget {
//
//   @override
//   State<data> createState() => _dataState();
// }
//
// final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// String myId = '';
// String myUsername = '';
// String myUrlAvatar = '';
//
// class _dataState extends State<data> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class data extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String myId = '';
  String myUsername = '';
  String myUrlAvatar = '';

  data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
