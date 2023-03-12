

import 'package:alumni_portal_flutter/helper/helper_functions.dart';
import 'package:alumni_portal_flutter/screens/chat_page.dart';
import 'package:alumni_portal_flutter/screens/profile_page.dart';
import 'package:alumni_portal_flutter/screens/signin_screen.dart';
import 'package:alumni_portal_flutter/services/auth_services.dart';
import 'package:alumni_portal_flutter/services/database_service.dart';
import 'package:alumni_portal_flutter/widgets/bottomnav.dart';
import 'package:alumni_portal_flutter/widgets/maindrawer.dart';
import 'package:alumni_portal_flutter/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal_flutter/utils/colors_utils.dart';
import 'package:alumni_portal_flutter/reusable_widgets/reusable_widgets.dart';
import 'package:alumni_portal_flutter/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;

  @override
  void initState(){
    super.initState();
    gettingUserdata();
  }

  gettingUserdata() async {
    await HelperFunction.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
     await HelperFunction.getUserNameFromSf().then((value) {
      setState(() {
        userName = value!;
      });
    });
     await DatabaseService(uid : FirebaseAuth.instance.currentUser!.uid).getUserGroups().then(
       (snapShots){
         setState(() {
           groups = snapShots;
         });
       }
     );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(userName: userName,email: email,),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            nextScreenReplace(context, ChatScreen());
          },icon: Icon(Icons.message_outlined))
        ],
        backgroundColor: Theme.of(context).primaryColor,

        title: const Text(
            "Home",
          style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      drawer: MainDrawer(userName: userName, email: email,),
      body: Center(
        child: ElevatedButton(
          child: const Text("LogOut"),
          onPressed: (){
            authService.signout().whenComplete(() => nextScreenReplace(context, const SignInScreen())); 
          },
        ),
      )
    );
  }
}


