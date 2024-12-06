import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        "MoveCare",
        style: GoogleFonts.raleway(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 22, 92, 29),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
