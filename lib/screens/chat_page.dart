
import 'package:alumni_portal_flutter/reusable_widgets/groutile_widget.dart';
import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:alumni_portal_flutter/screens/search_page.dart';
import 'package:alumni_portal_flutter/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../helper/helper_functions.dart';
import '../services/auth_services.dart';
import '../services/database_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Map<String, dynamic> userData = {};

  final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState(){
    super.initState();
    gettingUserdata();
  }

  String getId(String res){
    return res.substring(0 , res.indexOf("_"));
  }
  String getName(String res){
    return res.substring(res.indexOf("_") + 1);
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

    await docRef.get().then(
          (DocumentSnapshot doc) {
            setState(() {
              userData = doc.data() as Map<String, dynamic>;
            });
      },
      onError: (e) => print("Error getting document: $e"),
    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          nextScreenReplace(context, const HomeScreen());
        }, icon: const Icon(Icons.home),

        ),
        actions: [
          IconButton(onPressed: (){
            nextScreen(context, const SearchPage());
          }, icon: const Icon(Icons.search) )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text("Chat" , style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold),),
      ),
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          popUpDialogBox(context);
        },
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add ,
          color: Colors.white,
          size : 30,
        ),
      ),
    );
  }
  //getting user snapshot for getting user group list
  // popUpDialogBox(BuildContext context){
  //     showDialog(
  //         barrierDismissible: false,
  //         context : context,
  //         builder: (context){
  //           return StatefulBuilder(
  //               builder: (context , setState){
  //           return AlertDialog(
  //             title: const Text('Create Group' , textAlign: TextAlign.center,),
  //             content: Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   _isLoading
  //                       ? Center(child: CircularProgressIndicator(
  //                           color: Theme.of(context).primaryColor,
  //                       ))
  //                       : TextField(
  //                     onChanged: (value){
  //                       setState(() {
  //                         groupName = value;
  //                       });
  //                     },
  //
  //                     style: const TextStyle(color: Colors.black),
  //                     decoration: InputDecoration(
  //                       enabledBorder: OutlineInputBorder(borderSide: const BorderSide(
  //                           color: Colors.black,),
  //                         borderRadius: BorderRadius.circular(10)
  //                       ),
  //                       errorBorder: OutlineInputBorder(borderSide: const BorderSide(
  //                           color: Colors.red,),
  //                         borderRadius: BorderRadius.circular(10)
  //                       ),
  //                       focusedBorder: OutlineInputBorder(borderSide: BorderSide(
  //                           color: Theme.of(context).primaryColor,),
  //                         borderRadius: BorderRadius.circular(10)
  //                       ),
  //
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             actions: [
  //               ElevatedButton(onPressed: ()async{
  //                 if (groupName != ""){
  //                   setState(() {
  //                     _isLoading = true;
  //                   });
  //                   DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).createGroup(
  //                       userName,
  //                       FirebaseAuth.instance.currentUser!.uid,
  //                       groupName);
  //                   Navigator.of(context).pop();
  //                   showSnackBar(context, Colors.green, "Groups Created Successfully");
  //                 }
  //               },
  //                 style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).primaryColor),
  //                 child: const Text("Create"),),
  //
  //
  //               ElevatedButton(onPressed: (){
  //                 Navigator.pop(context);
  //               },
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Theme.of(context).primaryColor),
  //                   child: const Text("Cancel"),)
  //             ],
  //           );});
  //     });
  // }

  popUpDialogBox(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Create a group",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                      : TextField(
                    onChanged: (val) {
                      setState(() {
                        groupName = val;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20)),
                        errorBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CANCEL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });
                      DatabaseService(
                          uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(userName,
                          FirebaseAuth.instance.currentUser!.uid, groupName)
                          .whenComplete(() {
                        _isLoading = false;
                      });
                      Navigator.of(context).pop();
                      showSnackBar(
                          context, Colors.green, "Group created successfully.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  child: const Text("CREATE"),
                )
              ],
            );
          }));
        });
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: userData['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                      groupId: (getId(userData["groups"][index])),
                      groupName: getName(userData["groups"][index]),
                      userName: userData["fullname"]);
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  noGroupWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              popUpDialogBox(context);
            },
            child: const Icon(Icons.add_circle , color: Colors.black12,size: 75,),
          ),
          const SizedBox(height: 20,),
          const Text('You Have not Joined any Group , tap on Add icon to create your First Group' , textAlign: TextAlign.center,)
        ],
      ),
    );
  }

}
