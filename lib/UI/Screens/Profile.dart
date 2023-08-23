import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_3/cubit/my_app_cubit.dart';
import 'package:task_3/cubit/my_app_state.dart';


import 'Login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  // void initState() {
  //   if (DataSource.isLoadingProfile) {
  //     Future.delayed(Duration.zero, () async {
  //       var data = await DataSource.getDataFromFirebase();
  //       setState(() {
  //         DataSource.userData = data;
  //         DataSource.isLoadingProfile = false;
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
        elevation: 0,

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
      body: BlocBuilder<AppCubitA, AppStateA>(
        builder: (context, state) {
          if (context
              .read<AppCubitA>()
              .userData != null) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 90,
                          backgroundImage: context.read<AppCubitA>().userData!.image == ''
                              ? const NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx9tjaExsY-srL4VsHNE_OKGVCJ-eIFNBktw&usqp=CAU')
                              : NetworkImage(
                              context.read<AppCubitA>().userData!.image),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(40)),
                            child: IconButton(
                                onPressed: () {
                                  context.read<AppCubitA>().pickImage();
                                },
                                icon: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 35,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  //       Container(
                  //           width: 300,
                  //           height: 80,
                  //           margin: const EdgeInsets.symmetric(
                  //               vertical: 10, horizontal: 45),
                  //           decoration: const BoxDecoration(
                  //               color: Colors.grey,
                  //               borderRadius:
                  //               BorderRadius.all(Radius.circular(10))),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(2.0),
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 const Padding(
                  //                   padding: EdgeInsets.all(7.0),
                  //                   child: Text(
                  //                     'First Name',
                  //                     style: TextStyle(
                  //                         fontSize: 20, color: Colors.white38),
                  //                   ),
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.only(left: 9),
                  //                   child: Text(
                  //                     context
                  //                         .read<AppCubitA>()
                  //                         .userData!
                  //                         .name,
                  //                     style: const TextStyle(
                  //                       fontSize: 25,
                  //                       color: Colors.white,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  // ),

                  // Container(
                  //     width: 300,
                  //     height: 80,
                  //     margin: const EdgeInsets.symmetric(
                  //         vertical: 10, horizontal: 45),
                  //     decoration: const BoxDecoration(
                  //         color: Colors.grey,
                  //         borderRadius: BorderRadius.all(Radius.circular(10))),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(2.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const Padding(
                  //             padding: EdgeInsets.all(7.0),
                  //             child: Text(
                  //               'Phone',
                  //               style: TextStyle(
                  //                   fontSize: 20, color: Colors.white38),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 9),
                  //             child: Text(
                  //               context.read<AppCubitA>().userData!.phone,
                  //               style: const TextStyle(
                  //                 fontSize: 25,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )),
                  ListTile(
                    tileColor: Colors.grey[350],
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black, width: 3)),
                    title: Text(
                      context
                          .read<AppCubitA>()
                          .userData!
                          .name,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.w400),
                    ),
                    leading: const Text('User Name :',
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    tileColor: Colors.grey[350],
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black, width: 3)),
                    title: Row(
                      children: [
                        Text(
                          context
                              .read<AppCubitA>()
                              .userData!
                              .email,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    leading:
                    const Text('Email :', style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    tileColor: Colors.grey[350],
                    style: ListTileStyle.list,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(color: Colors.black, width: 3)),
                    title: Text(
                      context
                          .read<AppCubitA>()
                          .userData!
                          .phone,
                      textAlign: TextAlign.start,
                      style:
                      const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    leading: const Text('Phone Number :',
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500)),
                  ),
                  // Container(
                  //     width: 300,
                  //     height: 80,
                  //     margin: const EdgeInsets.symmetric(
                  //         vertical: 10, horizontal: 45),
                  //     decoration: const BoxDecoration(
                  //         color: Colors.grey,
                  //         borderRadius: BorderRadius.all(Radius.circular(10))),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(2.0),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           const Padding(
                  //             padding: EdgeInsets.all(7.0),
                  //             child: Text(
                  //               'Email',
                  //               style: TextStyle(
                  //                   fontSize: 20, color: Colors.white38),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 9),
                  //             child: Text(
                  //               context
                  //                   .read<AppCubitA>()
                  //                   .userData!
                  //                   .email,
                  //               style: const TextStyle(
                  //                 fontSize: 25,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  // ),
                ],
              ),
            );
          } else {
            return const Text('error###');
          }
        },
      ),
    );
  }
}
