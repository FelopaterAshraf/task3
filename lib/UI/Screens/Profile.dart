import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Data/Get data/Data source.dart';
import 'Login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    if (DataSource.isLoadingProfile) {
      Future.delayed(Duration.zero, () async {
        var data = await DataSource.getDataFromFirebase();
        setState(() {
          DataSource.userData = data;
          DataSource.isLoadingProfile = false;
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
        elevation: 0,
        title: const Text('Profile',
            style: TextStyle(fontSize: 30, color: Colors.black)),
        centerTitle: true,
        actions: [
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
      body: DataSource.isLoadingProfile
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 300,
                        height: 80,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 45),
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Text(
                                  'First Name',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white38),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Text(
                                  DataSource.userData!.name,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
                Container(
                    width: 300,
                    height: 80,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white38),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Text(
                              DataSource.userData!.phone,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                    width: 300,
                    height: 80,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 45),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white38),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9),
                            child: Text(
                              DataSource.userData!.email,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
    );
  }
}
