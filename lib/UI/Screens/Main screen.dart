import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../Data/Models.dart';
import '../Widget/AddProduct.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<List<Product>> getData() async {
    final response =
    await http.get(Uri.parse('https://dummyjson.com/products'));
    List<Product> product = [];

    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (var item in jsonResponse['products']) {
        product.add(Product.fromJson(item));
      }
    }
    return product;
  }
  List<Product> product = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      var data = await getData();
      setState(() {
        product = data;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GridView.builder(
          itemCount: product.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 330,
              crossAxisCount: 2, childAspectRatio: (1 / 2)),
          itemBuilder: (BuildContext context, int index) {
            return AddProduct(product: product[index]);
          }),
    );
  }
}
