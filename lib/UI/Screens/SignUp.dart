import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'MyHomePage.dart';

class createAccount extends StatefulWidget {
  const createAccount({super.key});

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> SignUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          if (value.user != null) {
            saveUserData(
              email: email,
              password: password,
              name: name,
              phone: phone,
              uid: value.user!.uid,
            ).then((value) {
              if (value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const MyHomePage();
                }));
              }
            });
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  Future<bool> saveUserData({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uid,
  }) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'uid': uid,
      }, SetOptions(merge: true));
      return true;
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('SignUp',
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
                    //NAME Container
                    const Padding(
                      padding: EdgeInsets.only(right: 240),
                      child: Text('Name',
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
                      child: TextFormField(
                        controller: name,
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
                    //Email Container
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
                      child: TextFormField(
                        controller: email,
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
                    //phone container
                    const Padding(
                      padding: EdgeInsets.only(right: 200),
                      child: Text('Phone',
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
                      child: TextFormField(
                        controller: phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your Phone number';
                          }else if (value.length < 11) {
                            return 'phone must be 11 number';
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    //Password Container
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
                      child: TextFormField(
                        controller: password,
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
                            await SignUp(
                              email: email.text,
                              password: password.text,
                              name: name.text,
                              phone: phone.text,
                            );
                          },
                          child: const Text('Sign Up',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
