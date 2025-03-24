import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movecare/screens/login_screen.dart';
//import 'package:movecare/screens/register_screen.dart';
//import 'package:movecare/widgets/my_bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
/*
 Future.delayed(const Duration(seconds: 5), (){
Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: 
  (_)=> const MyBottomNavbar(),));
 });
 */
Future.delayed(const Duration(seconds: 5), () {
  if (!mounted) return; // ✅ Widget hala ekranda mı kontrol et
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => const LoginScreen()),
  );
});
  }
    @override
 void dispose(){
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
  super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [ Colors.white, Colors.green ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft
          ),
        ),
child: const Center(
  child: SizedBox(
    width: 300, // Maksimum genişlik
    height: 300, // Maksimum yükseklik
    child: Image(
      image: AssetImage("assets/images/splash.png"),
      fit: BoxFit.contain, // Görsel oranını korur
    ),
  ),
),
    
      ),
      );
  
  }
}
