
import 'dart:html';
import 'package:alumni_portal_flutter/screens/chat_page.dart';
import 'package:alumni_portal_flutter/screens/signin_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal_flutter/utils/colors_utils.dart';
import 'package:alumni_portal_flutter/reusable_widgets/reusable_widgets.dart';
import 'package:alumni_portal_flutter/screens/signup_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
          }, icon: Icon(Icons.message_outlined))
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
            "Home",
          style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              signInSignUpButtons(context, false, () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }
}


