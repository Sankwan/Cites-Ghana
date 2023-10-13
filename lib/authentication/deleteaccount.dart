import 'package:cites/authentication/auth.api.dart';
import 'package:cites/authentication/signup.dart';
import 'package:cites/widgets/pagesnavigator.dart';
import 'package:flutter/material.dart';

class DeleteAccountDialogue {
  String email = '';

  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('This action cannot be undone. Are you sure?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Perform account deletion logic here
            deleteAccount(email);
            Navigator.of(context).pop(); // Close the dialog
            // Navigate to a confirmation or logout page
            nextNavRemoveHistory(context, const SignupPage());
          },
          child: const Text('Yes, Delete'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
