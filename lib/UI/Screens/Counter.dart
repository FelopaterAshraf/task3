import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/cubit/my_app_cubit.dart';
import 'package:task_3/cubit/my_app_state.dart';

import 'Login.dart';

class Counter extends StatelessWidget {
  Counter({super.key});

  final TextEditingController input1Controller = TextEditingController();
  final TextEditingController input2Controller = TextEditingController();

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
          'Counter',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<AppCubitA, AppStateA>(
            builder: (context, state) {
              return Text(
                'sum = ${context
                    .read<AppCubitA>()
                    .sum}',
                style:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              );
            },
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(45.0),
                child: Container(
                    width: 300,
                    height: 80,
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: input1Controller,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Input 1',
                            hintStyle:
                            TextStyle(color: Colors.black, fontSize: 20)),
                        keyboardType: TextInputType.number,
                      ),
                    )),
              ),
            ],
          ),
          Container(
              width: 300,
              height: 80,
              decoration: const BoxDecoration(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: input2Controller,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input 2',
                      hintStyle: TextStyle(color: Colors.black, fontSize: 20)),
                  keyboardType: TextInputType.number,
                ),
              )),
          const SizedBox(
            height: 25,
          ),
          BlocBuilder<AppCubitA, AppStateA>(
            builder: (context, state) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown),
                  onPressed: () {
                    context.read<AppCubitA>().getSum(
                      double.parse(input1Controller.text),
                      double.parse(input2Controller.text),
                    );
                  },
                  child: const Text(
                    'get sum',
                    style: TextStyle(fontSize: 15),
                  ));
            },
          )
        ],
      ),
    );
  }
}
