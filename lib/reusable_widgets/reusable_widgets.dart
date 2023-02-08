
import 'dart:html';

import 'package:flutter/material.dart';

Image logoWidget(String imageName){
  return Image.asset(
    imageName ,
    fit:BoxFit.fitWidth,
    width: 240,
    height: 240,
    // color: Colors.white,
  );
}

TextField reusableTextField(String text , IconData icon ,bool isPasswordType , TextEditingController controller){

  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color:  Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(prefixIcon: Icon(icon , color: Colors.white70,),
    labelText: text,
    labelStyle: TextStyle(color: Colors.white70.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior:FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0) ,
          borderSide: const BorderSide(width: 0 , style: BorderStyle.none))
    ),
    keyboardType:
    isPasswordType?TextInputType.visiblePassword :
    TextInputType.emailAddress,
  );
}

Scaffold personalChat(BuildContext context , String name){
  TextEditingController message_controller = TextEditingController();
  return Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
      ],
      title: Text(name ,
        style: const TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),),
      centerTitle: true,
      backgroundColor: Colors.black,
      elevation: 0,
    ),
    body: Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          child: Container(
            width: MediaQuery.of(context).size.width ,
            padding: const  EdgeInsets.symmetric(horizontal: 20 , vertical: 18),
            color: Colors.grey[700],
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  controller: message_controller,
                  style: TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Write Here",
                    hintStyle: TextStyle(color: Colors.white , fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: const  Center(
                    child: Icon(Icons.send , color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Container signInSignUpButtons(BuildContext context , bool isLogin , Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width*0.7,
    height: 50,
    margin: const  EdgeInsets.fromLTRB(0 , 20 , 0 , 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if (states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Colors.orange;
      }),shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      child: Text(
        isLogin ? "LOG IN" : "Sign Up",
        style: const TextStyle(
          color: Colors.black87 ,fontWeight: FontWeight.bold ,fontSize: 16),
        ),
    ),
  );
}