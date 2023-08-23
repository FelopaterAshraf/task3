import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_3/Data/Models/Models.dart';
import 'package:task_3/Data/Models/User_data.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'my_app_state.dart';

class AppCubitA extends Cubit<AppStateA> {
  AppCubitA() : super(MyAppInitial());

  List<Product> product = [];

  UserDataModel? userData;

  Future<void> getData() async {
    try {
      emit(LoadingState());
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        for (var item in jsonResponse['products']) {
          product.add(Product.fromJson(item));
        }
      }
      emit(DoneState());
    } catch (error) {
      emit(ErrorState());
    }
  }

  Future<void> getDataFromFirebase() async {
    try {
      emit(GetDatLoadingState());
      String? uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userA =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      userData = UserDataModel(
          name: userA['name'],
          password: userA['password'],
          phone: userA['phone'],
          email: userA['email'],
          uid: userA['uid'],
          image: userA['image']);
      emit(GetDatDoneState());
    } catch (e) {
      emit(GetDatErrorState(e.toString()));
    }
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        if (value.user != null) {
          emit(LoginDoneState());
        }
      });
    } catch (error) {
      emit(LoginErrorState(error.toString()));
    }
  }

  Future<void> SignUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      emit(CreateAccLoadingState());
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
              emit(CreateAccDoneState());
            } else {
              emit(CreateAccErrorState('saveUserData Error'));
            }
          });
        }
      });
    } catch (e) {
      emit(CreateAccErrorState(e.toString()));
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
        'image': '',
      }, SetOptions(merge: true));
      return true;
    } catch (error) {
      return false;
    }
  }

  double sum = 0;

  void getSum(
    double input1,
    double input2,
  ) {
    sum = input1 + input2;
    emit(GetSum());
  }

  ImagePicker picker = ImagePicker();
  File? img;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      img = File(image.path);
      uploadImageToUserData(File(image.path));
      emit(PickImagesState());
    } else {
      print('null image');
    }
  }

  Future<void> uploadImageToUserData(File image) async {
    try {
      emit(UploadLoadingState());
      String uid = FirebaseAuth.instance.currentUser!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child(' usersImages')
          .child('${DateTime.now()}.jpg');

      await ref.putFile(File(image.path));

      String? url;

      url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'image': url,
      });

    } catch (e) {
    }
  }
}
