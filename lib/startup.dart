import 'package:flutter/material.dart';
import 'package:redefine_sales_app/main.dart';

import 'helpers/ProfilePage.dart';
import 'helpers/theme.dart';

class startUpPage extends StatefulWidget {
  const startUpPage({Key? key}) : super(key: key);

  @override
  State<startUpPage> createState() => _startUpPageState();
}

class _startUpPageState extends State<startUpPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MyHomePage(title: "ERP"),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton.extended(
      //   elevation: 2,
      //   foregroundColor: Colors.white,
      //   backgroundColor: primar,
      //   onPressed: () {
      //     Navigator.of(context).pushReplacement(MaterialPageRoute(
      //       builder: (context) => const CreateTask(),
      //     ));
      //   },
      //   label: const Text("New Task"),
      //   icon: const Icon(Icons.add, size: 25),
      // ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            )
          ]),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded, size: 25),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.settings, size: 25),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
