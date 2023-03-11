import 'package:alumni_portal_flutter/shared/constants.dart';
import 'package:flutter/material.dart';


const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black12 , fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff090000) , width:2)
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff020000) , width:2)
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffd31a1a), width:2)
  )
);

void nextScreen(context , page){
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
void nextScreenReplace(context , page){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
}

void showSnackBar(context , color , message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content : Text(message , style: const TextStyle(fontSize: 14 )),
      backgroundColor : color ,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK", onPressed: (){},
        textColor: Colors.white,)));
}