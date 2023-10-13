import 'dart:async';
import 'package:cites/authentication/login.dart';
import 'package:cites/screens/homepage.dart';
import 'package:cites/widgets/customwidgets.dart';
import 'package:cites/widgets/formfields.dart';
import 'package:cites/widgets/pagesnavigator.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import '../animation/slideanimate.dart';
import 'auth.api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WriteSQLdata extends StatefulWidget {
  const WriteSQLdata({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WriteSQLdataState();
  }
}

class _WriteSQLdataState extends State<WriteSQLdata> {
  late bool error, sending, success;
  late String msg;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  String selectedCountry = '';
  String selectedCountryCode = '';
  String selectedCountryName = '';

  final TextEditingController lastPasswordController = TextEditingController();
  bool _isLoading = false; // Track loading state
  String _errorMessage = ''; // Store error message

  @override
  void dispose() {
    // TODO: implement dispose
    fullnameController.dispose();
    emailController.dispose();
    numberController.dispose();
    lastPasswordController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> sendUserData(
    String fullname,
    String email,
    String phone_number,
    String country,
    String country_code,
    String password,
    String status,
  ) async {
    String url = 'http://fciis2.fcghana.org/cites/v1/users/insert.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'fullname': fullname,
          'email': email,
          'phone_number': phone_number,
          //save country code n name into database
          'country_code': selectedCountryCode,
          'country': selectedCountryName,
          'password': password,
          'status': '0',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        // Handle non-200 status codes
        print('Server returned status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues)
      print('Error sending data: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFffffff),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Center(
                    child: Image.asset(
                  'assets/images/citeslogo.jpg',
                  height: 120,
                  width: 220,
                )),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'New to Cites?',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Register to use App',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    controller: fullnameController,
                    label: 'full name',
                    icon: Icons.person,
                    hint: 'full name',
                    validator: nameValidator),
                const SizedBox(
                  height: 15.0,
                ),
                CustomTextField(
                    controller: emailController,
                    label: 'email',
                    icon: Icons.mail,
                    hint: 'email',
                    validator: emailValidator),
                const SizedBox(
                  height: 15.0,
                ),

                //numberformfield
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: numberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.phone),
                    hintText: 'phone number',
                    labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  validator: numberValidator,
                ),

                const SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: _selectCountry,
                  child: AbsorbPointer(
                      child: CustomTextField(
                          controller:
                              TextEditingController(text: selectedCountry),
                          label: 'select your country',
                          icon: Icons.flag,
                          hint: 'select your country',
                          validator: countryValidator)),
                ),
                const SizedBox(
                  height: 15.0,
                ),

                //password field
                PasswordFormField(
                    controller: lastPasswordController,
                    label: 'password',
                    icon: Icons.lock,
                    validator: passwordValidator),
                const SizedBox(height: 35),
                //change made here
                PrimaryButton(
                  onpress: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true; // Start loading animation
                      });

                      var fullname = fullnameController.text;
                      var email = emailController.text;
                      var number = numberController.text;
                      var country = selectedCountry;
                      var country_code = selectedCountry;
                      var password = lastPasswordController.text;
                      var status = '0';

                      var response = await sendUserData(
                        fullname,
                        email,
                        number,
                        country,
                        country_code,
                        password,
                        status,
                      );

                      if (response != null) {
                        if (response['status'] != null && response['status']) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(snackBar);

                          // Registration successful, stop loading and navigate to the homepage
                          setState(() {
                            _isLoading = false; // Stop loading animation
                          });
                          nextNavRemoveHistory(context, MyHomePage());
                        } else {
                          // Registration failed, show error message for a few seconds
                          setState(() {
                            _isLoading =
                                true; // Keep loading animation for error message
                            _errorMessage = response.containsKey('message')
                                ? response['message']
                                : 'Registration failed';
                          });

                          // Delay for a few seconds and then stop loading
                          Timer(const Duration(seconds: 3), () {
                            setState(() {
                              _isLoading = false;
                              _errorMessage = ''; // Clear error message
                            });
                          });
                        }
                      } else {
                        // Network error or other issue
                        setState(() {
                          _isLoading = true;
                          _errorMessage =
                              'An error occurred. Please check your connection and try again.';
                        });

                        // Delay for a few seconds and then stop loading
                        Timer(const Duration(seconds: 3), () {
                          setState(() {
                            _isLoading = false;
                            _errorMessage = '';
                          });
                        });
                      }
                    }
                  },
                  label: 'REGISTER',
                ),

                // Show loading animation if _isLoading is true
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),

                // Show error message if _errorMessage is not empty
                if (_errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectCountry() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500,
        // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country.displayName;
          selectedCountryCode = country.countryCode;
          selectedCountryName = country.name;
        });
      },
    );
  }
}
