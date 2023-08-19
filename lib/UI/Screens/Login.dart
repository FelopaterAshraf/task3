import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_3/UI/Screens/SignUp.dart';

import 'MyHomePage.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login(
      String email,
      String password,
      ) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          if (value.user != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return const MyHomePage();
                }));
          }
        });
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('login',
            style: TextStyle(fontSize: 40, color: Colors.black)),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 240),
                      child: Text('Email',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      width: 300,
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 45),
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please write your email';
                            }
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 200),
                      child: Text('Password',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      width: 300,
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 45),
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must be not empty';
                            } else if (value.length < 6) {
                              return 'password must be 6 numbers';
                            }
                          },
                          decoration:
                          const InputDecoration(border: InputBorder.none),
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(180, 50),
                            backgroundColor: Colors.brown,
                          ),
                          onPressed: () async {
                            await login(
                              email.text,
                              password.text,
                            );
                          },
                          child: const Text('Login',
                              style: TextStyle(fontSize: 25)),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('OR',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.brown,
                      fontWeight: FontWeight.w700)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 50),
                    backgroundColor: Colors.brown,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                createAccount()));
                  },
                  child: const Text('Create Account',
                      style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
