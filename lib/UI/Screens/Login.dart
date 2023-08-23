import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/UI/Screens/SignUp.dart';
import 'package:task_3/cubit/my_app_cubit.dart';
import 'package:task_3/cubit/my_app_state.dart';

import 'MyHomePage.dart';

class login extends StatelessWidget {
  login({super.key});

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 35, bottom: 30),
                child: Text('Welcome back! Glad \nto see you, Again!',
                    style: TextStyle(fontSize: 32, fontFamily: 'IBMPlexSans')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                            controller: email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please write your email';
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 20),
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.only(right: 200),
                      //   child: Text('Password',
                      //       style: TextStyle(
                      //           color: Colors.grey,
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.w600)),
                      // ),
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
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 20),
                                border: InputBorder.none),
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocConsumer<AppCubitA, AppStateA>(
                            listener: (context, state) {
                              if (state is LoginErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.error,
                                    ),
                                  ),
                                );
                              } else if (state is LoginDoneState) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const MyHomePage();
                                }));
                              }
                            },
                            builder: (context, state) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: const Size(320, 50),
                                  backgroundColor: Colors.deepPurple[900],
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AppCubitA>().login(
                                            email.text,
                                            password.text,
                                          );
                                    }
                                  }
                                },
                                child: state is LoginLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Login',
                                        style: TextStyle(fontSize: 25)),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
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
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Row(
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
                          image: const DecorationImage(fit: BoxFit.fill,
                            image: AssetImage(
                              'assets/images/apple pic.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Don\'t have an accounr?', style: TextStyle(fontSize:18,fontWeight: FontWeight.w400)),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                                     builder: (context) => createAccount()));
                    },
                    child: const Text(' Register Now',style: TextStyle(color: Colors.red,fontSize: 20)),
                  )
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       fixedSize: const Size(180, 50),
                  //       backgroundColor: Colors.transparent,
                  //       foregroundColor: Colors.red,
                  //       elevation: 0),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => createAccount()));
                  //   },
                  //   child: const Text('Create Account',
                  //       style: TextStyle(fontSize: 20)),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
