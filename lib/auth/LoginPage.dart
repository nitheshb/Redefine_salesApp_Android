// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../helpers/ButtonClass.dart';
import '../helpers/firebase_help.dart';
import '../helpers/methods.dart';
import '../helpers/theme.dart';
import '../main.dart';
// import 'package:todo/helpers/methods.dart';
// import 'package:todo/ui/startup.dart';
// import 'package:todo/helpers/theme.dart';
// import 'package:todo/ui/firebase_help.dart';

// import '../ui/ButtonClass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool isLoading = false;
  bool _passwordVisible = false;
  String? localFcmToken = "";
  String? loggedInFcmToken = "";

  var userDetails = [];

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        localFcmToken = token;
        print("Local fcm token is $token");
      });
    });
  }

  void getLoggedInUserDetails() async {
    var x = await DBQuery.instanace.getLoggedInUserDetails(currentUser?.uid);
    // print("ewfwfe ${x.data()}");
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    getToken();
    getLoggedInUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: isLoading
          ? Center(
              child: SizedBox(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 40.0, right: 40.0, top: 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 43.0, bottom: 81),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('REDEFINE ERP',
                              style: TextStyle(
                                color: greyHeading,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ))
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 81,
                    // ),
                    SizedBox(
                      width: size.width / 1.1,
                      child: Text("Sign In", style: kTitleFont),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: size.width / 1.1,
                      child: Text("Sign In to continue", style: kSubTitleFont),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: field(
                            size, "YOUR EMAIL", Icons.close_rounded, _email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: passwordfield(
                            size,
                            "your password".toUpperCase(),
                            Icons.close_rounded,
                            _password),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    customButton(size),
                  ],
                ),
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });
          logIn(_email.text, _password.text).then((user) {
            if (user != null && localFcmToken != null) {
              print("Login Sucessfull");
              setState(() {
                isLoading = false;
              });
              var currentUser = FirebaseAuth.instance.currentUser;

              FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser?.uid)
                  .update({"user_fcmtoken": localFcmToken}).then((_) {
                print("success!");
              });
              Navigator.pushReplacement(
                  (context),
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: "ERP",
                          )));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill form correctly");
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primary,
            ),
            alignment: Alignment.center,
            child: Text(
              "Sign in",
              style: kButtonFont,
            )),
      ),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return SizedBox(
      height: 60,
      child: TextField(
        style: kTextFont,
        controller: cont,
        decoration: InputDecoration(
          suffixIcon: CircleIconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                cont.clear();
              });
            },
          ),
          labelText: hintText,
          labelStyle: kHeadingFont,
        ),
      ),
    );
  }

  Widget passwordfield(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return SizedBox(
      height: 60,
      //width: size.width / 1.1,
      child: TextFormField(
        style: kTextFont,
        controller: cont,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
              size: 20,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),

          // suffixIcon: CircleIconButton(
          //   icon: icon,
          //   onPressed: () {
          //     this.setState(() {
          //       cont.clear();
          //     });
          //   },),
          labelText: hintText,
          labelStyle: kHeadingFont,
        ),
      ),
    );
  }
}
