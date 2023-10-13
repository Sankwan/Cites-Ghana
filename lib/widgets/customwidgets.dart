import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onpress;
  final String label;
  const PrimaryButton({Key? key, required this.onpress, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'Montserrat', fontSize: 18)),
        ),
      ),
    );
  }
}
//awesome snackbars

  var snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Welcome Back!',
      message:
          'Login has been done successfully',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );

    var snackBarSign = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Great!',
      message:
          'Your account has been created successfully',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );


var snackBarMail = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Password Reset Successful!',
      message:
          'Check the link sent to your email to reset your password',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.success,
    ),
  );


   var snackBarError = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      color: const Color(0xFF8D6E63),
      title: 'Oh Snap!',
      message:
          'There was an error. Check your credentials and try again',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.warning,
    ),
  );

   var snackBarNetwork = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Network Issues!',
      message:
          'There was an error. Check your network connectivity and try again',

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.warning,
    ),
  );
