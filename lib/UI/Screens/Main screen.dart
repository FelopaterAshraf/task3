import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../Data/Get data/Data source.dart';
import '../../Data/Models/Models.dart';
import '../Widget/AddProduct.dart';
import 'Login.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    if (DataSource.isLoading) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.getData();
        setState(() {
          DataSource.product = data;
          DataSource.isLoading = false;
        });
      });
    }
    super.initState();
  }
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
        actions: [
          const Center(
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
             ),
          IconButton(
            onPressed: () async {
              await signOut().then((value) {
                if (value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                        return const login();
                      }));
                }
              });
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: DataSource.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: DataSource.product.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 330,
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 2)),
              itemBuilder: (BuildContext context, int index) {
                return AddProduct(product: DataSource.product[index]);
              }),
    );
  }
}
