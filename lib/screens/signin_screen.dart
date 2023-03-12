

import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:alumni_portal_flutter/services/auth_services.dart';
import 'package:alumni_portal_flutter/services/database_service.dart';
import 'package:alumni_portal_flutter/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal_flutter/utils/colors_utils.dart';
import 'package:alumni_portal_flutter/reusable_widgets/reusable_widgets.dart';
import 'package:alumni_portal_flutter/screens/signup_screen.dart';

import '../helper/helper_functions.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthService authService = AuthService();
  bool _isloading = false;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  final formKey = GlobalKey<FormState>();


  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _isloading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical:80),
          child: Form(
            key : formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                const SizedBox(height: 20,),
                Image.asset(
                  "assets/images/alumni_logo.png",
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20,),
                const Text(
                  'Alumni Portal' ,
                  style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50,),

                TextFormField(
                  decoration: textInputDecoration.copyWith(
                    labelText: "Email" ,
                    prefixIcon: const Icon(
                      Icons.email ,
                      color: Colors.black45,
                    )
                  ),
                  onChanged: (value){
                    setState(() {
                      email = value;
                      print(email);
                    });
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                      labelText: "Password" ,
                      prefixIcon: const Icon(
                        Icons.lock ,
                        color:  Colors.black45,
                      )
                  ),
                  validator: (val){
                    if (val!.length < 6){
                      return 'Password must be atleast 6 Characters';
                    }
                    else {
                      return null;
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      password = value;
                      print(password);
                    });
                  },
                ),
                const SizedBox(height: 20) ,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text('Sign In' , style: TextStyle(fontSize: 16 , color :Colors.white)),
                    onPressed : (){
                      login();
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Text.rich(
                  TextSpan(
                    text: "Dont have An Account? ",
                    style: TextStyle(fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Register Here',
                        style: const TextStyle(decoration: TextDecoration.underline , fontSize: 14),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          nextScreen(context, const SignUpScreen());
                        })
                    ] ,

                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async{
    if(formKey.currentState!.validate()){
      setState(() {
        _isloading = true;
      });
      await authService.loggInWithUserNameAndPassword(email, password).then((value) async{
        print("Hello");
        if (value == true) {
          QuerySnapshot snapshot = await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUsenameSF(
            snapshot.docs[0]['fullname']   //in the form of multidimensional array
          );
          await HelperFunction.saveUserEmailSF(email);
          nextScreenReplace(context, HomeScreen());

        }
        else{
          showSnackBar(context ,  Colors.red , value);
          setState(
                  ()=>{
                _isloading = false
              }
          );
        }
      });
    }

  }

}
