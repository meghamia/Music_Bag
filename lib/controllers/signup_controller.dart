




import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../screens/home_page.dart';


class SignupController extends GetxController {
  String userName = '';
  String userEmail = '';
  String userId = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final key1= GlobalKey<FormState>();
  bool isVisible=false;
  void pressOnPasswordIcon(){
    isVisible=!isVisible;
    update();
  }

  var isLoading = false;

  bool passwordVisible = false;

  Future<void> signUp() async {
    try {
      isLoading=true;



      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text,
      );

      // Store user information in Firestore
      await FirebaseFirestore.instance
          .collection(Constants.usersCollection)
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
        // Add other fields if needed
      });
      userId = userCredential.user!.uid;
      userName = nameController.text;
      userEmail = emailController.text;
      // Display success message
      Get.snackbar('Success', 'Account created successfully',
          snackPosition: SnackPosition.BOTTOM);

      // Navigate to home page after successful signup
      if (isLoading) {
        await saveUserInformation(userEmail, passwordController.text,userName);
        Get.off(() => HomePage());
      }


      isLoading=false;
    } catch (error) {
      isLoading=false;
      Get.snackbar('Error', error.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }

  Future<void> saveUserInformation(String email, String password,String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('name', name);
    print('User information saved: Email - $email, Password - $password , Name -$name');
  }






}