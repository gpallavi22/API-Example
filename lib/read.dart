import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api_model.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}


class _ReadDataState extends State<ReadData> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: _usersStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      var usersData = snapshot.data!.docs;

      return ListView.builder(
        itemCount: usersData.length,
        itemBuilder: (context, index) {
          var userData = usersData[index].data();
          return ListTile(
            title: Text(userData['First Name'].toString()),
            subtitle: Text(userData['Last Name'].toString()),

          );
        },
      );
    },
    ),
    );



  }
}
