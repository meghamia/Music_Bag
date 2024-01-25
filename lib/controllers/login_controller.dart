import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/controllers/songPlayerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../screens/home_page.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final fetchUserData = FirebaseAuth.instance.currentUser?.uid;
    // fetchUserData(FirebaseAuth.instance.currentUser!.uid);
  }

  final key = GlobalKey<FormState>();
  bool isVisible = false;
  void pressOnPasswordIcon() {
    isVisible = !isVisible;
    update();
  }

  var isLoading = false.obs;

  // Email validation using regex pattern
  bool isValidEmail(String email) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  bool passwordVisible = false;

  Future<bool> areCredentialsValid(
      String enteredEmail, String enteredPassword) async {
    try {
      // Use Firebase Authentication to check if credentials are valid
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: enteredEmail,
        password: enteredPassword,
      );
      if (userCredential.user != null) {
        await fetchUserData(userCredential.user!.uid);
      }

      // If login is successful, return true
      return userCredential.user != null;
    } catch (error) {
      print('Error validating credentials: $error');
      return false;
    }
  }

  Future<void> saveUserInformation(
      String email, String password, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('name', name);
    //  print('User information saved: Email - $email, Password - $password , Name -$name');
  }

  Future<void> fetchUserData(String userId) async {
    try {
      // Fetch user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Access user information from the snapshot and update preferences or state as needed
      String userEmail = userSnapshot['email'];
      String userName = userSnapshot['name'];

      // Save user information in SharedPreferences
      await saveUserInformation(userEmail, passwordController.text, userName);
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
}
