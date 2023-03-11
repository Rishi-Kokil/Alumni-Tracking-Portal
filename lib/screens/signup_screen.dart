import 'package:alumni_portal_flutter/helper/helper_functions.dart';
import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:alumni_portal_flutter/screens/signin_screen.dart';
import 'package:alumni_portal_flutter/services/auth_services.dart';
import 'package:alumni_portal_flutter/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
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
  // TextEditingController _usernameTextController = TextEditingController();
  // TextEditingController _passwordTextController = TextEditingController();
  // TextEditingController _emailTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // String passwd = "New";

  String email = "";
  String password = "";
  String fullName = "";
  bool _isloading = false;
  AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: _isloading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo_alumni_portal_1.png",
                    width: 250,
                    height: 250,
                  ),
                  // const Text(
                  //   'Alumni Tracking System' ,
                  //   style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold ),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        labelText: "Full Name",
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black45,
                        )
                    ),
                    onChanged: (value) {
                      setState(() {
                        fullName = value;
                        print(fullName);
                      });
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }
                      else{
                         return "Name Cannot be Empty";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        labelText: "Email",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black45,
                        )
                    ),
                    onChanged: (value) {
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
                        labelText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black45,
                        )
                    ),
                    validator: (val) {
                      if (val!.length < 6) {
                        return 'Password must be atleast 6 Characters';
                      }
                      else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        password = value;
                        print(Icons.password);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                        child: const Text('Sign Up',
                            style: TextStyle(fontSize: 16, color: Colors
                                .white)),
                        onPressed: () {
                          register();
                        },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text.rich(
                      TextSpan(
                        text: "Already Have an account? ",
                        style: const TextStyle(fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Login Now',
                              style: const TextStyle(decoration: TextDecoration
                                  .underline, fontSize: 14),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(context, const SignInScreen());
                                })
                        ],

                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    register () async{
      if(formKey.currentState!.validate()){

        setState(() {
          _isloading = true;
        });
        await authService.registerUserWithEmailAndPassword(fullName, email, password).then((value) async{
          if (value == true) {
            //Saving shared preference state
            await HelperFunction.saveUserLoggedInStatus(value);
            await HelperFunction.saveUsenameSF(fullName);
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

