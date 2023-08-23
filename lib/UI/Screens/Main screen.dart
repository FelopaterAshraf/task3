import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:task_3/cubit/my_app_cubit.dart';
import 'package:task_3/cubit/my_app_state.dart';
import 'dart:convert' as convert;

import '../../Data/Get data/Data source.dart';
import '../../Data/Models/Models.dart';
import '../Widget/AddProduct.dart';
import 'Login.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  // void initState() {
  //   if (DataSource.isLoading) {
  //     Future.delayed(Duration.zero, () async {
  //       var data = await DataSource.getData();
  //       setState(() {
  //         DataSource.product = data;
  //         DataSource.isLoading = false;
  //       });
  //     });
  //   }
  //   super.initState();
  // }
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
                    return login();
                  }));
                }
              });
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      body: BlocConsumer<AppCubitA, AppStateA>(listener: (context, state) {
        if (state is ErrorState) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('ERRORRRR'),
              );
            },
          );
          print('WWWW');
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DoneState ||
            context.read<AppCubitA>().product.isNotEmpty) {
          return GridView.builder(
              itemCount: context.read<AppCubitA>().product.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 330,
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 2)),
              itemBuilder: (BuildContext context, int index) {
                return AddProduct(
                    product: context.read<AppCubitA>().product[index]);
              });
        } else {
          return const Center(
            child: Text("~~~error~~~"),
          );
        }
      }),
    );
  }
}
