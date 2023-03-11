import 'package:alumni_portal_flutter/helper/helper_functions.dart';
import 'package:alumni_portal_flutter/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Login
  Future loggInWithUserNameAndPassword(String email , String password) async{
    try{
      final creadential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      print(creadential);
      return true;

    }on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        print("User Not Found");
        return "User Not Found";
      }
      else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return 'Wrong password provided for that user.';
      }
    }
  }

  //Register
  Future registerUserWithEmailAndPassword(String fullName , String email , String password) async{
    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password)).user!;

      if(user != null){
        await DatabaseService(uid: user.uid).saveUserData(fullName, email);
        return true;
      }
    }on FirebaseAuthException catch (e){
      return e.message;
    }
  }
  //SignOut

  Future signout() async{
    try{
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUsenameSF("");
      await HelperFunction.saveUserEmailSF("");
      await firebaseAuth.signOut();
    }catch (e){
      return null;
    }
  }



}