import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:alumni_portal_flutter/screens/signin_screen.dart';
import 'package:alumni_portal_flutter/screens/updateprofile.dart';
import 'package:alumni_portal_flutter/widgets/maindrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/helper_functions.dart';
import '../services/auth_services.dart';
import '../services/database_service.dart';
import '../widgets/bottomnav.dart';
import '../widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  ProfilePage({Key? key, required this.email, required this.userName}) : super(key: key);


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  Map<String, dynamic> userData = {};

  String company = "Testing";
  String position = "Testing";

  final docRef = FirebaseFirestore.instance.collection("profile").doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState(){
    super.initState();
    // gettingUserdata();
  }

  // gettingUserdata() async {
  //   await docRef.get().then(
  //         (DocumentSnapshot doc) {
  //       setState(() {
  //         userData = doc.data() as Map<String, dynamic>;
  //       });
  //     },
  //     onError: (e) => print("Error getting document: $e"),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(userName: widget.userName ,email : widget.email),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      title: const Text("Profile" , textAlign: TextAlign.center,style: TextStyle(
        color: Colors.white ,
        fontWeight: FontWeight.bold,
      ),),
        actions: [
          IconButton(onPressed: (){
            nextScreen(context, UpdateProfilePage());
          }, icon: Icon(Icons.settings))
        ],
    ),
      drawer: MainDrawer(userName: widget.userName, email: widget.email,),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30 , vertical: 40
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.person_rounded, size: 140 ,color: Colors.black87,),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('UserId :' , style: TextStyle(fontSize: 12),),
                    Text(FirebaseAuth.instance.currentUser!.uid , style: const TextStyle(fontSize: 12),),
                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.black45,

                ),
                rowArrangement("Full Name", widget.userName),
                rowArrangement("Email", widget.email),
                rowArrangement("company", company),
                rowArrangement("position", position),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  rowArrangement(String text1 , String text2 ){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5 , vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$text1 :", style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
          Text(text2, style: TextStyle(fontSize: 15),),
        ],
      ),
    );
  }
}
