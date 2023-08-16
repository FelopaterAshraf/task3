import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_3/Data/Models.dart';

class AddProduct extends StatelessWidget {
  final Product product;
  const AddProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    int y=product.price;
    String x="\$$y";
    return Column(
          children: [
            Stack(
                children: [
              Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Image(
                  image: NetworkImage(product.thumbnail),
                ),
              ),
              const Positioned( 
                  top: 3,
                  right: 3,
                  child: Icon(CupertinoIcons.heart
                    ,color: Colors.red,
                  ))
            ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                      child: Text(product.description ,textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15, color: Colors.grey)),
                    ),
              ],
            ),
            Text(x,
                style: const TextStyle(fontSize: 20, color: Colors.black)),
          ],
    );
  }
}
