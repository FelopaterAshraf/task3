import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:task_3/UI/Screens/Counter.dart';
import '../../Data/Models.dart';
import '../Widget/AddProduct.dart';
import 'package:http/http.dart' as http;

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
      currentIndex = index ;
    });
  }

  List<Widget> screens = [
  const MainScreen(),
  const Counter(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'New Products',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'See All',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body:screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
      currentIndex:0,
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
            icon: Icon(Icons.home, color: Colors.white), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline_sharp, color: Colors.white),
          label: 'Counter',
        ),
      ],
    ),);
  }
}
