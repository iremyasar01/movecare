import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movecare/widgets/my_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? userData;

  String? currentPassword;
  String? password;
  String? confirmPassword;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId != null) {
      final url = 'http://localhost:5166/api/Users/GetUser?id=$userId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          userData = jsonDecode(response.body);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load user data')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found. Please log in.')),
      );
    }
  }

 Future<void> updatePassword(String currentPassword, String newPassword) async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getInt('userId');

  if (userId != null) {
    final url = 'http://localhost:5166/api/Users/UpdatePassword';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': newPassword, // Bu satır eklendi
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password: ${response.body}')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 40.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/splash.png',
                          height: 180,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          buildTextField('Username', userData!['username']),
                          const SizedBox(height: 10),
                          buildTextField('Name',
                              "${userData!['name']} ${userData!['surname']}"),
                          const SizedBox(height: 10),
                          buildTextField('Email', userData!['email']),
                          const SizedBox(height: 10),
                          buildTextField(
                              'Phone Number', userData!['phoneNumber']),
                          const SizedBox(height: 10),
                          buildEditableField('Current Password'),
                          const SizedBox(height: 10),
                          buildEditableField('New Password'),
                          const SizedBox(height: 10),
                          buildEditableField('Confirm Password'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                if (password == confirmPassword) {
                                  updatePassword(
                                      currentPassword!, password!);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Passwords do not match.')),
                                  );
                                }
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
                              "Save",
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

  Widget buildTextField(String label, String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }

  Widget buildEditableField(String label) {
    return TextFormField(
      obscureText: true,
      onSaved: (value) {
        if (label == 'Current Password') {
          currentPassword = value;
        } else if (label == 'New Password') {
          password = value;
        } else if (label == 'Confirm Password') {
          confirmPassword = value;
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}


