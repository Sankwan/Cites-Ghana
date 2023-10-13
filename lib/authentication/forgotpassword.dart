import 'dart:convert';
import 'package:cites/authentication/login.dart';
import 'package:cites/widgets/customwidgets.dart';
import 'package:cites/widgets/formfields.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<Map<String, dynamic>?> resetPassword(String email) async {
    const url = 'http://fciis2.fcghana.org/cites/v1/users/reset_password.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseData = json.decode(response.body);
        print('API Response: $response');

        if (responseData['success']) {
          // Password reset successful
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBarMail);

          // Clear the email field
          emailController.clear();
        } else {
          // Password reset failed
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBarError);
          print('password reset failed');
        }
      } else {
        // Handle non-200 status codes
        ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBarNetwork);
        print('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      print('Error sending data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Forgotten Password?',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Fill in the form to reset your password',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Build the "Email" TextFormField
                      buildTextField(
                        context,
                        emailController,
                        'Email',
                        Icons.email,
                        'enter your email address',
                        emailValidator,
                      ),
                      const SizedBox(height: 30),
                      // Submit button
                      PrimaryButton(
                        onpress: () async {
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text;

                            // Call the function to send data to PHP backend and handle the response
                            final response = await resetPassword(email);

                            // The resetPassword function will show a SnackBar based on the response
                          }
                        },
                        label: 'SUBMIT',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
