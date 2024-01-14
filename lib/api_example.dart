import 'dart:convert';
import 'package:apiexample/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiExample extends StatefulWidget {
  @override
  _ApiExampleState createState() => _ApiExampleState();
}

class _ApiExampleState extends State<ApiExample> {

  final String apiUrl = 'https://reqres.in/api/users?page=1';
  // Replace with your API endpoint

  Future<GetApiModel> fetchApiData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return GetApiModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Example'),
      ),
      body: FutureBuilder<GetApiModel>(
        future: fetchApiData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            GetApiModel apiData = snapshot.data!;
            return ListView.builder(
              itemCount: apiData.data?.length ?? 0,
              itemBuilder: (context, index) {
                Data userData = apiData.data![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(userData.avatar ?? ''),
                  ),
                  title: Text('${userData.firstName} ${userData.lastName}'),
                  subtitle: Text(userData.email ?? ''),
                );
              },
            );
          }
        },
      ),
    );
  }
}
