import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_3/UI/Screens/Counter.dart';
import 'package:task_3/UI/Screens/Profile.dart';
import '../../Data/Models/Models.dart';
import '../Widget/AddProduct.dart';
import 'package:http/http.dart' as http;
import 'Login.dart';
import 'Main screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  void getPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> screens = [
    const MainScreen(),
    const Counter(),
    const Profile(),
  ];
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          getPage(index);
        },
        backgroundColor: Colors.brown,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        unselectedLabelStyle:
            const TextStyle(color: Colors.white, fontSize: 18),
        selectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 18),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.white), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, color: Colors.white),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
