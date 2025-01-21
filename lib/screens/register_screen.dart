import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
                    // Username
                    buildTextField("username", false),
                    const SizedBox(height: 10),

                    // Email
                    buildTextField("email", false),
                    const SizedBox(height: 10),

                    // Name
                    buildTextField("name", false),
                    const SizedBox(height: 10),

                    // Surname
                    buildTextField("surname", false),
                    const SizedBox(height: 10),

                    // Password
                    buildTextField("password", true),
                    const SizedBox(height: 10),

                    // Again Password
                    buildTextField("again password", true),
                    const SizedBox(height: 20),

                    // Save Button
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Kayıt işlemleri
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
  Widget buildTextField(String hintText, bool isPassword) {
    return TextFormField(
      obscureText: isPassword,
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
        return null;
      },
    );
  }
}
