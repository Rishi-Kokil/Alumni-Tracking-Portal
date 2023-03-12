import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _nameController=TextEditingController();
  final _domainController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*backgroundColor: Colors.green,*/
        elevation: 0,
        title: const Text("Get in touch",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      ),
      drawer: Drawer(

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextField(controller: _nameController,
                decoration: InputDecoration(labelText: "Enter your Name",border: OutlineInputBorder()),

              ),
              SizedBox(
                height: 30,
              ),
              TextField(controller: _nameController,
                decoration: InputDecoration(labelText: "Enter your E-mail",border: OutlineInputBorder()),

              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _domainController,
                decoration: InputDecoration(
                    labelText: "Message",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 70),
              ElevatedButton(onPressed:(){
                Navigator.pop(context);
              }
                  , child: Text("Submit"))
            ],
          ),
        ),
      ),

    );
  }
}