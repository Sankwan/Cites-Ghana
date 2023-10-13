import 'package:bot_toast/bot_toast.dart';
import 'package:cites/animation/slideanimate.dart';
import 'package:cites/authentication/auth.api.dart';
import 'package:cites/authentication/forgotpassword.dart';
import 'package:cites/authentication/signup.dart';
import 'package:cites/screens/homepage.dart';
import 'package:cites/utils/users.api.dart';
import 'package:cites/widgets/customwidgets.dart';
import 'package:cites/widgets/formfields.dart';
import 'package:cites/widgets/pagesnavigator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoggingIn = false; // Track whether login is in progress
  bool loginError = false;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                    'assets/images/citeslogo.jpg',
                    height: 120,
                    width: 220,
                  )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Login to use App',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(children: <Widget>[
                //email form field
                CustomTextField(
                    controller: emailController,
                    label: 'email',
                    icon: Icons.mail,
                    hint: 'email',
                    validator: emailValidator),
                const SizedBox(height: 25),
                PasswordFormField(
                    controller: passwordController,
                    label: 'password',
                    icon: Icons.lock,
                    validator: passwordValidator),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PasswordResetPage()));
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  onpress: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoggingIn = true; // Start the login process
                        loginError = false; // Reset login error status
                      });

                      var email = emailController.text;
                      var password = passwordController.text;

                      try {
                        BotToast.closeAllLoading();

                        var data = await fetchSingleUsers(
                          context: context,
                          email: email,
                          password: password,
                        );

                        // Close the loading toast
                        BotToast.closeAllLoading();

                        if (data != null) {
                          // Login successful, navigate to MyHomePage
                          if (mounted) {
                            setState(() {
                              isLoggingIn =
                                  false; // Stop the circular progress indicator
                            });
                          }
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("email", email);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);

                          nextNavRemoveHistory(context, MyHomePage());
                        } else {
                          // Login failed, set error status and show snackbar
                          if (mounted) {
                            setState(() {
                              isLoggingIn =
                                  false; // Stop the circular progress indicator
                              loginError = true;
                            });
                          }
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBarError);
                        }
                      } catch (error) {
                        // Handle network or other errors here
                        if (mounted) {
                          setState(() {
                            isLoggingIn =
                                false; // Stop the circular progress indicator
                            loginError = true;
                          });
                        }
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBarError);
                      }
                    }
                  },
                  label: isLoggingIn ? 'LOGGING IN...' : 'LOG IN',
                ),
                if (isLoggingIn) // Display circular progress indicator while logging in
                  const Center(child: CircularProgressIndicator()),
              ]),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'New to CITES?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SignupPage()));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
