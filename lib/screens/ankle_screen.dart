import 'package:flutter/material.dart';
import 'package:movecare/widgets/my_appbar.dart';

class AnkleScreen extends StatelessWidget {
  const AnkleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
         
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/ankle.png', // Görseli projenize eklemeyi unutmayın
              height: 200,
            ),
          ),
        ],
      ),
    );
    
  }
}