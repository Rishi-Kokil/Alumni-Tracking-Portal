import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/helper_functions.dart';
import '../reusable_widgets/createjob.dart';
import '../services/auth_services.dart';
import '../services/database_service.dart';
import '../services/jobcrude.dart';
import '../utils/colors_utils.dart';
import '../widgets/bottomnav.dart';
import '../widgets/maindrawer.dart';

class JobHomePage extends StatefulWidget {
  const JobHomePage({Key? key}) : super(key: key);

  @override
  State<JobHomePage> createState() => _JobHomePageState();
}

class _JobHomePageState extends State<JobHomePage> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();

  JobCrudMethods crudMethods = new JobCrudMethods();
  var jobStream;

  @override
  void initState() {
    super.initState();
    gettingUserdata();

    crudMethods.getData().then((result) {
      jobStream = result;
      setState(() {});
    });
    super.initState();
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

  Widget JobsList(){
    return Container(
      /*height: MediaQuery.of(context).size.height,*/
      /*margin: EdgeInsets.only(bottom: 16),*/
        child: jobStream !=null ?Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: jobStream,
                builder: (context,snapshot){
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder:(context,index){
                        return JobsTile(
                          name: snapshot.data!.docs[index].get('name'),
                          company: snapshot.data!.docs[index].get('company'),
                          jobTitle: snapshot.data!.docs[index].get('jobTitle'),
                          desc: snapshot.data!.docs[index].get('desc'),
                          contact: snapshot.data!.docs[index].get('contact'),
                        );
                      }
                  );
                }
            )
            /*ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
             itemCount: blogsSnapshot.docs.length,
             shrinkWrap: true,
             itemBuilder:(context,index){
               return BlogsTile(
                   imgUrl: blogsSnapshot.docs[index].get('imgUrl'),
                   title: blogsSnapshot.docs[index].get('title'),
                   description: blogsSnapshot.docs[index].get('desc'),
                   authorName: blogsSnapshot.docs[index].get('authorName'),);
             }
         )*/
          ],
        ):Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(userName: userName,email: email,),
      drawer: MainDrawer(userName: userName, email: email,),
      appBar: AppBar(
        title: Row(
          children: const <Widget>[
            Text("Job",style: TextStyle(
              fontSize: 22,
            ),),
            Text("Posts",style: TextStyle(
                fontSize: 22,color: Colors.black
            ),)
          ],),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: JobsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateJob()));
              },
            )
          ],),
      ),
    );
  }
}


class JobsTile extends StatelessWidget {
  String name="";
  String company="";
  String jobTitle="";
  String desc="";
  String contact="";
  JobsTile({required this.name,required this.company,required this.jobTitle,required this.desc,required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 170,
      child: Stack(children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
        ),
        Container(
          height: 170,
          decoration: BoxDecoration(
            color: hexStringToColor("#faf6eb"),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black12),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              rowArrangement("Comapant Name", company),
              rowArrangement("Job Desc", desc),
              rowArrangement("Posted By", name),
              rowArrangement("Contact info", contact),

            ],
          ),)
      ],),
    );
  }

  rowArrangement(String text1 , String text2 ){
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text("$text1 :", style: TextStyle(fontSize: 17 , fontWeight: FontWeight.bold),),
        Text(text2, style: TextStyle(fontSize: 17),),
      ],
    ),
    );
  }
}