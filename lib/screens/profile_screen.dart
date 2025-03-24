import 'package:flutter/material.dart';
import 'package:movecare/services/netcore_service.dart';
import 'package:movecare/widgets/my_appbar.dart';


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
    final userService = NetcoreService();
    final result = await userService.getUserData();

    if (result != null && result.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['error'])),
      );
    } else {
      setState(() {
        userData = result;
      });
    }
  }

  Future<void> updatePassword(String currentPassword, String newPassword) async {
    final userService = NetcoreService();
    final result = await userService.updatePassword(currentPassword, newPassword);

    if (result != null && result.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['error'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully!')),
      );
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




