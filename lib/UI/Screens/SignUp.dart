import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_3/cubit/my_app_cubit.dart';
import 'package:task_3/cubit/my_app_cubit.dart';
import 'package:task_3/cubit/my_app_state.dart';

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
  TextEditingController confirmpassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only( left: 30,bottom: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:SvgPicture.asset('assets/images/backArrow.svg',) ,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35, bottom: 30),
                child: Text('Welcome back! Glad \nto see you, Again!',
                    style: TextStyle(fontSize: 32, fontFamily: 'IBMPlexSans')),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write your Name';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(
                              color: Colors.grey[500], fontSize: 20),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please write your Email';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Colors.grey[500], fontSize: 20),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter your phone Number';
                          } else if (value.length < 11) {
                            return 'Please Enter a valid phone number';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          hintStyle: TextStyle(
                              color: Colors.grey[500], fontSize: 20),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
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
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Colors.grey[500], fontSize: 20),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 60,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(width: 2, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: confirmpassword,
                        validator: (value) {
                          if (value != password.text) {
                            return 'Please make sure that your password match';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirmpassword',
                          hintStyle: TextStyle(
                              color: Colors.grey[500], fontSize: 20),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  BlocConsumer<AppCubitA, AppStateA>(
                    listener: (context, state) {
                      if (state is CreateAccErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.error,
                            ),
                          ),
                        );
                      } else if (state is CreateAccDoneState) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const MyHomePage();
                        }));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)),
                                fixedSize: const Size(320, 50),
                                backgroundColor: Colors.deepPurple[900],
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await context
                                      .read<AppCubitA>()
                                      .SignUp(
                                          email: email.text,
                                          password: password.text,
                                          name: name.text,
                                          phone: phone.text);
                                }
                              },
                              child: state is CreateAccLoadingState
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Register',
                                      style: TextStyle(fontSize: 20)
                              ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                      child: const Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                        height: 36,
                                      )),
                                ),
                                Text('Or Login with',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w700)),
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                                      child: const Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                        height: 36,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                      Border.all(width: 2, color: Colors.grey.shade500),
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/facebook pic.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                      Border.all(width: 2, color: Colors.grey.shade500),
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/google icon.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                      Border.all(width: 2, color: Colors.grey.shade500),
                                      color: Colors.white,
                                    ),
                                    child: SvgPicture.asset('assets/images/appleicon.svg',fit: BoxFit.scaleDown,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 50,)


                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
