import 'package:flutter/material.dart';
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
          // Hemşire görseli
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/nurse.png', // Görseli projenize ekleyin
              height: 250,
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
                _buildButton('arms'),
                _buildButton('hands'),
                _buildButton('legs'),
                _buildButton('shoulder'),
              ],
            ),
          ),
        ],
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'history',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // Buton oluşturan yardımcı fonksiyon
  Widget _buildButton(String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green[400],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Butona basılınca yapılacak işlem
      },
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
       ),
      ),
       
    );
  }
}