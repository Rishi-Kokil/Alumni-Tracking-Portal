

import 'package:alumni_portal_flutter/reusable_widgets/reusable_widgets.dart';
import 'package:alumni_portal_flutter/screens/home_screen.dart';
import 'package:alumni_portal_flutter/utils/colors_utils.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String groupName = "Default";
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
      body: Container(
          width: MediaQuery.of(context).size.width*1,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children:<Widget> [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: ListTile(
                        title: const Text("CSI VESIT"),
                        subtitle: const Text("Message from abcd person"),
                        tileColor: Colors.black12,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => personalChat(context, "CSI VESIT")
                          ));
                        },
                      ),
                    )
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: ListTile(
                        title: const Text("Mini project"),
                        subtitle: const Text("Message from xyz person"),
                        tileColor: Colors.black12,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => personalChat(context, "Mini project")
                          ));
                        },
                      ),
                    )
                ),
              ],
            ),
          ),
      ),
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

  // noGroupWidget(){
  //   return Container(
  //     padding: const EdgeInsets.symmetric(vertical:10 , horizontal: 25),
  //     child: Column(),
  //   );
  // }

  popUpDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text(
          "Create A Group",
          textAlign: TextAlign.left,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min ,
          children: [
            TextField(
              onChanged: (val){
                setState(() {
                  groupName = val;
                });
              },
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,),
                  borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,),
                  borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,),
                  borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
        actions: [
          ElevatedButton(
              onPressed: (){},
              child: const Text("Cancel" ,
                style: TextStyle(fontSize: 20)),),
          ElevatedButton(
              onPressed: (){},
              child: const Text("Create" ,
                  style: TextStyle(fontSize: 20)))
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    });
  }
  //

}


