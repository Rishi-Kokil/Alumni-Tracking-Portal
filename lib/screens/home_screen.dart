

import 'package:alumni_portal_flutter/helper/helper_functions.dart';
import 'package:alumni_portal_flutter/screens/chat_page.dart';
import 'package:alumni_portal_flutter/screens/signin_screen.dart';
import 'package:alumni_portal_flutter/services/auth_services.dart';
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            const Icon(
              Icons.account_circle , size: 150 , color: Colors.black12,),
            const SizedBox(height: 10,),
            Text(
              email,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),
            const Divider(height: 2,),
            ListTile()
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("LogOut"),
          onPressed: (){
            authService.signout();
            nextScreenReplace(context, SignInScreen());
          },
        ),
      )
    );
  }
}


