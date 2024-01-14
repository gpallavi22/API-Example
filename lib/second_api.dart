import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api_model.dart';

class SecondApi extends StatefulWidget {
  const SecondApi({super.key});

  @override
  State<SecondApi> createState() => _SecondApiState();
}

class _SecondApiState extends State<SecondApi> {

  final String apiUrl = 'https://www.balldontlie.io/api/v1/players';
  // Replace with your API endpoint

  Future<ApiModel> fetchApiData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return ApiModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ApiModel>(
        future: fetchApiData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            ApiModel apiData = snapshot.data!;
            return ListView.builder(
              itemCount: apiData.data?.length ?? 0,
              itemBuilder: (context, index) {
                Data userData = apiData.data![index];
                return ListTile(

                  title: Text('${userData.firstName} ${userData.lastName}'),
                  subtitle: Text(userData.team.toString() ?? ''),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Map <String, dynamic> data={

                        "First Name" :userData.firstName,
                        "Last Name" : userData.lastName,
                        "Team" :userData.team!.name

                      };
                  try{
                      FirebaseFirestore.instance.collection("users").add(data);


                  }on FirebaseAuthException catch(ex){
                      log(ex.code.toString());
                  }



                    },
                    child: Text("Add to favourite"),

                  ),
                );
              },
            );
          }
        },
      ),


    );
  }
}
