import 'dart:convert';
import 'package:cites/screens/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../utils/users.api.dart';

//sign up user
Future<Map> fetchUsers({fullname, email, country, password}) async {
  String url = "http://fciis2.fcghana.org/cites/v1/users/create.php";
  // String url = "http://10.5.4.39/users/create.php";
  final response = await http.post(Uri.parse(url), body: {
    "fullname": fullname,
    "email": email,
    "country": country,
    "password": password
  });
  return jsonDecode(response.body);
}

//login the user
Future<Map<String, dynamic>?> fetchSingleUsers(
    {required BuildContext context,
    required String email,
    required String password}) async {
  String url =
      "http://fciis2.fcghana.org/cites/v1/users/login.php?email=$email&password=$password";
  final response = await http.get(Uri.parse(url));
  var jsonRes = await jsonDecode(response.body);

  // logger.d(response.body);
  // logger.d(email);
  // logger.d(password);
  // logger.d(fetchSingleUsers(email: email, password: password, context: context));

  if (jsonRes['log_status'] == true) {
    print('successful fetch of user data');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  } else if (jsonRes['log_status'] == false) {
    throw Exception('Failed to fetch user data');
  }
  return Future.value(jsonRes);
}


//delete user account
Future<bool> deleteAccount(String email) async {
  const url = 'http://fciis2.fcghana.org/cites/v1/users/delete.php';
  final response = await http.post(
    Uri.parse(url),
    body: {'email': email},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['status'];
  } else {
    throw Exception('Failed to delete account');
  }
}

//fetch users details into profile page
Future<Map<String, dynamic>> retrieveUsers(String email) async {
  const url = 'http://fciis2.fcghana.org/cites/v1/users/retrieve.php';
  final response = await http.post(
    Uri.parse(url),
    body: {'email': email},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['data'];
  } else {
    throw Exception('Failed to fetch user details');
  }
}
