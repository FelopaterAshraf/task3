// import 'dart:convert' as convert;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import '../Models/Models.dart';
// import '../Models/User_data.dart';
//
// class DataSource {
//   static Future<List<Product>> getData() async {
//     final response =
//     await http.get(Uri.parse('https://dummyjson.com/products'));
//     List<Product> productsList = [];
//
//     if (response.statusCode == 200) {
//       var jsonResponse =
//       convert.jsonDecode(response.body) as Map<String, dynamic>;
//       for (var item in jsonResponse['products']) {
//         productsList.add(Product.fromJson(item));
//       }
//     }
//     return productsList;
//   }
//
//   static List<Product> product = [];
//   static bool isLoading = true;
//   static bool isLoadingProfile = true;
//
//   static Future<UserDataModel?> getDataFromFirebase() async {
//     try {
//       String? uid = FirebaseAuth.instance.currentUser!.uid;
//       UserDataModel? user;
//       DocumentSnapshot userA =
//       await FirebaseFirestore.instance.collection('users').doc(uid).get();
//       user = UserDataModel(
//         name: userA['name'],
//         password: userA['password'],
//         phone: userA['phone'],
//         email: userA['email'],
//         uid: userA['uid'],
//       );
//       return user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   static UserDataModel? userData;
// }
