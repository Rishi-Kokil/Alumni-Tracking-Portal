
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/jobcrude.dart';


class CreateJob extends StatefulWidget {
  const CreateJob({Key? key}) : super(key: key);

  @override
  State<CreateJob> createState() => _CreateJobState();
}


class _CreateJobState extends State<CreateJob> {
  String name="";
  String jobTitle="";
  String desc="";
  String contact="";
  String company="";
  JobCrudMethods crudMethods=new JobCrudMethods();
  var selectedImage;
  bool _isLoading=false;
  uploadJob() async {
    Map<String, String> jobMap = {
      "name": name,
      "jobTitle": jobTitle,
      "desc": desc,
      "contact": contact,
      "company": company,
    };
    crudMethods.addData(jobMap).then((result) {
      Navigator.pop(context);
    });
    setState(() {
      _isLoading=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("Post",style: TextStyle(
              fontSize: 22,
            ),),
            Text("JobDetails",style: TextStyle(
                fontSize: 22,color: Colors.lightBlueAccent
            ),)
          ],),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              uploadJob();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.file_upload)),
          ),
        ],
      ),
      body: _isLoading?Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Tiny people searching for business opportunities.jpg")
                    )
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Name"),
                      onChanged: (val){
                        name=val;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextField(
                      decoration: InputDecoration(hintText: "Company Name"),
                      onChanged: (val){
                        company=val;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextField(
                      decoration: InputDecoration(hintText: "Job Title"),
                      onChanged: (val){
                        jobTitle=val;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextField(
                      decoration: InputDecoration(hintText: "Description"),
                      onChanged: (val){
                        desc=val;
                      },
                    ),
                    SizedBox(height: 8,),
                    TextField(
                      decoration: InputDecoration(hintText: "Contact Info"),
                      onChanged: (val){
                        contact=val;
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}