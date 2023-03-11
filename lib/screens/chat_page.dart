
import 'package:alumni_portal_flutter/screens/search_page.dart';
import 'package:alumni_portal_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            nextScreenReplace(context, SearchScreen());
          }, icon: const Icon(Icons.search) )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text("Chat" , style: TextStyle(fontSize: 27 , fontWeight: FontWeight.bold),),

      ),
    );
  }
}
