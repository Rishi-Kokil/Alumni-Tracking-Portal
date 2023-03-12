import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import 'crud.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String authorName="";
  String title="";
  String desc="";
  CrudMethods crudMethods=new CrudMethods();
  var selectedImage;
  bool _isLoading=false;
  Future getImage() async{
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        selectedImage=File(pickedImage.path);
      });
    }

  }

  uploadBlog() async{
    if(selectedImage !=null){
      setState(() {
        _isLoading=true;
      });
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task = firebaseStorageRef.putFile(selectedImage);
      var downloadUrl=await(await task).ref.getDownloadURL();
      print("this is url $downloadUrl");
      Map<String,String> blogMap={
        "imgUrl":downloadUrl,
        "authorName":authorName,
        "title":title,
        "desc":desc
      };
      crudMethods.addData(blogMap).then((result){
        Navigator.pop(context);
      });
    }else{

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("Create",style: TextStyle(
              fontSize: 22,
            ),),
            Text("Blog",style: TextStyle(
                fontSize: 22,color: Colors.lightBlueAccent
            ),)
          ],),
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              uploadBlog();
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
      ):Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: selectedImage!=null?
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 170,width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.file(selectedImage,fit: BoxFit.cover,
                  ),
                ),
              ):
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 170,width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.add_a_photo),
              ),
            ),
            SizedBox(height: 8,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: "Author Name"),
                    onChanged: (val){
                      authorName=val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Title"),
                    onChanged: (val){
                      title=val;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Description"),
                    onChanged: (val){
                      desc=val;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}