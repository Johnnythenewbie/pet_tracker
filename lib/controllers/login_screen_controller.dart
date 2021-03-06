import 'package:dog_tracker/controllers/user_controller.dart';
import 'package:dog_tracker/services/api/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;
  RxBool _isLoggingIn = false.obs;
  RxBool get isLoggingIn => _isLoggingIn;

  @override
  void onInit() async {
    //checks to see if the user signs in or out, using the FirebaseAuth Singleton
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  ///Signs in a new user ,
  ///
  /// {String} email - the user's email address
  ///
  /// {String} password - user's account password
  ///
  ///if there's an error then a snackbar shows the user the error
  void login(String email, String password) async {
    try {
      _isLoggingIn.value = true;
      _isLoggingIn.refresh();
      UserCredential _user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Get.find<UserController>().user =
          await Database.db.getUser(_user.user.uid);
      Get.offNamed("/homescreen");
    } catch (error) {
      _isLoggingIn.value = false;
      _isLoggingIn.refresh();
      Get.snackbar("Login Error", error);
      rethrow;
    }
  }
}
