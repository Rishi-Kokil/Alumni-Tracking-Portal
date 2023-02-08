import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal_flutter/utils/colors_utils.dart';
import 'package:alumni_portal_flutter/reusable_widgets/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpScreen  extends StatefulWidget {
  const SignUpScreen ({Key? key}) : super(key: key);

  @override
  State<SignUpScreen > createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen > {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
        "Sign Up" ,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
        )
      ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:[
              hexStringToColor("#DC8665"),
              hexStringToColor("#CD7672"),
              hexStringToColor("#534666")
              ], begin: Alignment.topCenter , end: Alignment.bottomCenter),),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height*0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Username", Icons.person_outline, false, _usernameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Email Id", Icons.person_outline, false, _emailTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Password", Icons.lock_outline, true, _passwordTextController),
                  signInSignUpButtons(context, false, () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text, password: _passwordTextController.text).then(
                            (value) =>
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()))
                    ).onError(
                            (error, stackTrace) => print("Error ${error.toString()}"));
                  })
                ],
              ),
            ),
          ),
        )
    );
  }
}

