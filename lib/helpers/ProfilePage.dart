import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redefine_sales_app/helpers/theme.dart';

import '../auth/LoginPage.dart';
// import 'package:todo/auth/LoginPage.dart';
// import 'package:todo/ui/Notifications.dart';
// import 'package:todo/helpers/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  String txt = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Profile',
                    style: kHeadingFont.copyWith(color: black, fontSize: 22),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                    child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 65,
                  child: Image.asset('assets/images/profile.png'),
                )),
                const SizedBox(
                  height: 25,
                ),
                Center(
                    child: Text(
                  "Ahnaf Irfan",
                  style: kTitleFont.copyWith(fontSize: 18),
                )),
                Center(
                    child: Text(
                  "${currentUser?.email}",
                  style: kSubTitleFont.copyWith(fontSize: 11),
                )),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Account Setting',
                    style: kHeadingFont.copyWith(color: black, fontSize: 14),
                  ),
                ),
                //SizedBox(height: 35,),
                Container(
                  //color:Colors.blue[50],
                  child: ListTile(
                    //leading: Icon(Icons.add),
                    title: Text(
                      'Your info',
                      style: kHeadingFont.copyWith(color: black, fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 15,
                      color: Colors.black,
                    ),
                    subtitle: Text(
                      'Edit and view your information',
                      style: kDescFont.copyWith(fontSize: 11),
                    ),
                    selected: true,
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Extra',
                    style: kHeadingFont.copyWith(color: black, fontSize: 14),
                  ),
                ),
                // Container(
                //   height: 40,
                //   //color:Colors.blue[50],
                //   child: ListTile(
                //     //leading: Icon(Icons.add),
                //     title: Text(
                //       'Notification',
                //       style: kDescFont.copyWith(fontSize: 12),
                //     ),
                //     trailing: const Icon(
                //       Icons.arrow_forward_ios_sharp,
                //       size: 15,
                //       color: Colors.black,
                //     ),
                //     selected: true,
                //     onTap: () {
                //       setState(() {
                //         Navigator.of(context).pushReplacement(MaterialPageRoute(
                //             builder: (_) => const Notifications()));
                //       });
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 40,
                  //color:Colors.blue[50],
                  child: ListTile(
                    //leading: Icon(Icons.add),
                    title: Text(
                      'Privacy & Policy',
                      style: kDescFont.copyWith(fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 15,
                      color: Colors.black,
                    ),
                    selected: true,
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const LoginPage()));
                        },
                        child: Text(
                          'Log Out',
                          style: kDescFont.copyWith(
                              fontSize: 15, color: Colors.red),
                        ))),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
