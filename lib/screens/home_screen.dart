import 'package:flutter/material.dart';
import 'package:movecare/screens/Backpain_screen.dart';
import 'package:movecare/screens/ankle_screen.dart';
import 'package:movecare/screens/arms_screen.dart';
import 'package:movecare/screens/eye_screen.dart';
import 'package:movecare/screens/hands_screen.dart';
import 'package:movecare/screens/knee_screen.dart';
import 'package:movecare/screens/legs_screen.dart';
import 'package:movecare/screens/muscle_screen.dart';
import 'package:movecare/screens/neck_screen.dart';
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
                  'Arm',
                 'assets/images/arm.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ArmsScreen()),
                  ),
                ),
                _buildButton(
                  'Leg',
                'assets/images/leg.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LegsScreen()),
                  ),
                ),
                _buildButton(
                  'Shoulder',
                   'assets/images/shoulder.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShoulderScreen()),
                  ),
                ),
                _buildButton(
                  'Hand',
                   'assets/images/hand.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HandsScreen()),
                  ),
                ),
                   _buildButton(
                  'Backpain',
                   'assets/images/backpain.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BackpainScreen()),
                  ),
                ),
                   _buildButton(
                  'Ankle',
                   'assets/images/ankle.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnkleScreen()),
                  ),
                ),
                   _buildButton(
                  'Muscle',
                   'assets/images/muscle.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MuscleScreen()),
                  ),
                ),
                   _buildButton(
                  'Eye',
                   'assets/images/eye.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EyeScreen()),
                  ),
                ),
                   _buildButton(
                  'Knee',
                   'assets/images/knee.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KneeScreen()),
                  ),
                ),
                  _buildButton(
                  'Neck',
                  'assets/images/neck.png',
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NeckScreen()),
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
  Widget _buildButton(String label, String assetPath, VoidCallback onPressed) {
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
          Image.asset(
            assetPath,
            width: 100, height: 100
          ),

          //Icon(icon, size: 40, color: Colors.white),
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

