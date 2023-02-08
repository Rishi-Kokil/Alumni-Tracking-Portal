

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ],
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Chat",
          style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          popUpDialog(context);
        },
        elevation: 0,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add , size: 30,),
      ),
    );
  }
  noGroupWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical:10 , horizontal: 25),
      child: Column(),
    );
  }

  popUpDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
          "Create A Group",
          textAlign: TextAlign.left,
        ),
        content: Column(),
      );
    });
  }
  //

}


