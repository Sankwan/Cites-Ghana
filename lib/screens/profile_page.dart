import 'package:cites/authentication/auth.api.dart';
import 'package:cites/authentication/deleteaccount.dart';
import 'package:cites/authentication/login.dart';
import 'package:cites/utils/users.api.dart';
import 'package:cites/widgets/pagesnavigator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  // prefs.remove("email");
  if (email != null) {
    return email;
  } else {
    throw Exception("Email not found");
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user;

// Fetch User information
  Future<void> getUser() async {
    String email = await getEmail();
    try {
      var user = await retrieveUsers(email);
      setState(() {
        this.user = user;
      });
      logger.d(user);
    } catch (error) {
      logger.d(error);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
        centerTitle: true,
        //not finished
        actions: [IconButton(onPressed: () {
          DeleteAccountDialogue();
        }, icon: const Icon(Icons.delete))],
      ),
      body:user == null ?
      const Center(
        child: CircularProgressIndicator(),
      )
       :ListView(
        children: [
          const SizedBox(height: 30),
          const CircleAvatar(
            radius: 50.0,
            child: Image(image: AssetImage('assets/images/cites.png')),
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              user['fullname'], // Display full name here'
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              user['email'], // Display email here
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Center(
            child: Text(
              user['phone_number'], // Display phone number here
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Center(
            child: Text(
              '${user['country']}, ${user['country_code']}', // Display country and country code here
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Center(
            child: TextButton(
              child: const Text(
                'Logout',
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("email");
                 nextNavRemoveHistory(context, LoginPage());
              },
            ),
          )
        ],
      ),
    );
  }
}

