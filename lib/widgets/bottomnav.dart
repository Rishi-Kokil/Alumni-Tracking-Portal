import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:alumni_portal_flutter/screens/profile_page.dart';
import 'package:alumni_portal_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class BottomNav extends StatelessWidget {
  final String userName;
  final String email;
  const BottomNav({Key? key, required this.email, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 3.0),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 2,
          padding: EdgeInsets.all(10),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',onPressed:(){
                nextScreenReplace(context, HomeScreen());
            } ,
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.notifications,
              text: 'Notifications',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Profile',
              onPressed: (){
                nextScreenReplace(context, ProfilePage(email: email, userName: userName));
              },
            ),
          ],
        ),
      ),
    );
  }
}
