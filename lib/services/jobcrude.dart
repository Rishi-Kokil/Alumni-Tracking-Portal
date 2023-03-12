import 'package:cloud_firestore/cloud_firestore.dart';

class JobCrudMethods{
  Future<void> addData(jobData) async{
    FirebaseFirestore.instance.collection("jobs").add(jobData).catchError((e){
      print(e);
    });
  }
  getData() async{
    return await FirebaseFirestore.instance.collection("jobs").snapshots();
  }
}