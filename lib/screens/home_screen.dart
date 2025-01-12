import 'package:flutter/material.dart';
import 'package:movecare/screens/arms_screen.dart';
import 'package:movecare/screens/hands_screen.dart';
import 'package:movecare/screens/legs_screen.dart';
import 'package:movecare/screens/shoulder_screen.dart';
import 'package:movecare/widgets/my_appbar.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Hemşire görseli
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/nurse.png', // Görseli projenize eklemeyi unutmayın
              height: 200,
            ),
          ),
          // GridView ile yeşil butonlar
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(16),
              children: [
                _buildButton(
                  'Arms',
                  Icons.back_hand_sharp,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ArmsScreen()),
                  ),
                ),
                _buildButton(
                  'Legs',
                  Icons.sign_language_sharp,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LegsScreen()),
                  ),
                ),
                _buildButton(
                  'Shoulders',
                  Icons.shape_line_rounded,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShoulderScreen()),
                  ),
                ),
                _buildButton(
                  'Hands',
                  Icons.calendar_today,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HandsScreen()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // İkon ve yazı içeren buton oluşturma
  Widget _buildButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

