import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
  });

  final IconData icon;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: 110,
      child: Card(
        color: Colors.blueGrey.shade500,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon),
            ),
            Text(
              text1,
              style: GoogleFonts.raleway(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              text2,
              style: GoogleFonts.raleway(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
