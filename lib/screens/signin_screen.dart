

import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal_flutter/utils/colors_utils.dart';
import 'package:alumni_portal_flutter/reusable_widgets/reusable_widgets.dart';
import 'package:alumni_portal_flutter/screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:[
                hexStringToColor("#DC8665"),
                hexStringToColor("#CD7672"),
                hexStringToColor("#534666")
              ], begin: Alignment.topCenter , end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,MediaQuery.of(context).size.height*0.2 , 20 , 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo1.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Entre Username", Icons.person_outline, false ,
                    _emailTextController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Entre Password", Icons.lock_outline, true ,
                    _passwordTextController),
                const SizedBox(
                  height: 20
                ),
                signInSignUpButtons(context, true, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                }
                ),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Dont't have account? ",
          style : TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

}