import 'package:flutter/material.dart';

Widget buildTextField(BuildContext context, TextEditingController controller, String label, IconData icon, String hint, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
        hintText: hint,
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      validator: validator,
    );
  }


Widget numberFormField(BuildContext context, TextEditingController controller, String label, IconData icon, String hint, String? Function(String?)? validator) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
        hintText: hint,
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      validator: validator,
    );
  }



class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;
  final String? Function(String?)? validator;

  const CustomTextField({super.key, 
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
        hintText: hint,
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      validator: validator,
    );
  }
}


  class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;

  const PasswordFormField({super.key, 
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
  });

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
        filled: true,
        hintText: widget.label,
        prefixIcon: Icon(widget.icon),
        labelStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}



// ... Email, name, staffId, and password validators as before ...
 String? emailValidator(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

 String? nameValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Name is required";
  }

  if (value.length < 2) {
    return "Name must be at least 2 characters long";
  }

  // You can add more specific validations for names, such as disallowing special characters or numbers.

  return null; // Return null if the name is valid
}

  String? staffIdValidator(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^\d+$').hasMatch(value)) {
      return "Numbers only)";
    }
    return null;
  }
  String? numberValidator(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^\d+$').hasMatch(value)) {
      return "Valid phone numbers only)";
    }
    return null;
  }
  String? countryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Select your country)";
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be at least 8 characters long";
    } else if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(value)) {
      return "Password should include at least one lowercase letter, one uppercase letter, one digit, and one special character (@\$!%*?&)";
    }
    return null; // Return null if the password is valid
  }