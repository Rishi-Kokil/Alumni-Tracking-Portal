import 'package:alumni_portal_flutter/screens/blogshomepage.dart';
import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:alumni_portal_flutter/screens/jobscreen.dart';
import 'package:alumni_portal_flutter/services/auth_services.dart';
import 'package:alumni_portal_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../screens/profile_page.dart';
import '../screens/signin_screen.dart';

class MainDrawer extends StatelessWidget {
  final userName;
  final email;

  MainDrawer({Key? key, this.userName, this.email}) : super(key: key);
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: <Widget>[
          const Icon(
            Icons.account_circle , size: 150 , color: Colors.black12,),
          const SizedBox(height: 10,),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 30,),
          const Divider(height: 2,),
          ListTile(
            onTap: (){
              nextScreenReplace(context, HomeScreen());
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            leading: const Icon(Icons.home),
            title: const Text("Home" ,
              style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            onTap: (){
              nextScreenReplace(context, ProfilePage(email: email, userName: userName,));
            },
            leading: const Icon(Icons.person),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            title: const Text("Profile" ,
              style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            onTap: (){
              nextScreenReplace(context, JobHomePage());
            },
            leading: const Icon(Icons.work),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            title: const Text("Job Post" ,
              style: TextStyle(color: Colors.black),),
          ),
          ListTile(
            onTap: (){
              nextScreenReplace(context, BlogHPage(userName: userName,email: email,));
            },
            leading: const Icon(Icons.chrome_reader_mode),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            title: const Text("Blogs" ,
              style: TextStyle(color: Colors.black),),
          ),

          ListTile(
            onTap: (){
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("LogOut"),
                      content: Text("Are you sure You want to logout?"),
                      actions: [
                        ElevatedButton(onPressed: (){
                          authService.signout().whenComplete(
                                  () async{
                                await authService.signout();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>
                                const SignInScreen()), (route) => false);
                              });
                        }, child: const Text("OK")),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text("Cancel")),
                      ],
                    );
                  });
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            leading: const Icon(Icons.exit_to_app),
            title: const Text("LogOut" ,
              style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    );
  }
}
