import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movecare/widgets/my_bottom_navbar.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordAgainController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    const String url = 'http://localhost:5166/api/Users/Registration';
    final Map<String, dynamic> requestBody = {
      'username': usernameController.text,
      'email': emailController.text,
      'name': nameController.text,
      'surname': surnameController.text,
      'phoneNumber': phoneNumberController.text,
      'password': passwordController.text,
      'passwordAgain': passwordAgainController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );
        // BottomNavBar'a yönlendirme
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyBottomNavbar()),
        );
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        if (responseData['Errors'] != null) {
          final errors = (responseData['Errors'] as List).join("\n");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Errors: $errors')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData.toString())),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected error occurred!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              const SizedBox(height: 70),
              // Logo ve başlık
              Column(
                children: [
                  Image.asset(
                    'assets/images/splash.png', // Logonuzun yolu
                    height: 180,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              // Form alanı
              Form(
                key: formKey,
                child: Column(
                  children: [
                    buildTextField("username", false, usernameController),
                    const SizedBox(height: 10),
                    buildTextField("email", false, emailController),
                    const SizedBox(height: 10),
                    buildTextField("name", false, nameController),
                    const SizedBox(height: 10),
                    buildTextField("surname", false, surnameController),
                    const SizedBox(height: 10),
                    buildTextField("phone number", false, phoneNumberController),
                    const SizedBox(height: 10),
                    buildTextField("password", true, passwordController),
                    const SizedBox(height: 10),
                    buildTextField("again password", true, passwordAgainController),
                    const SizedBox(height: 20),

                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              passwordAgainController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match'),
                              ),
                            );
                            return;
                          }
                          registerUser(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, bool isPassword,
      TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType:
          hintText == "phone number" ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$hintText cannot be empty";
        }
        if (hintText == "phone number" && value.length < 10) {
          return "Phone number must be at least 10 digits";
        }
        return null;
      },
    );
  }
}




