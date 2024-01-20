import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HourlyForcastItem extends StatelessWidget {
  const HourlyForcastItem({
    super.key,
    required this.time,
    required this.temperature,
    required this.icon,
  });
  final String time;
  final String temperature;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: SizedBox(
        width: 130, // Fixed width for each card
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                time,
                style: GoogleFonts.raleway(
                    fontSize: 16, fontWeight: FontWeight.w600),
                maxLines: 1,
              ),
              Icon(
                icon,
                size: 40,
              ),
              Text(
                temperature,
                style: GoogleFonts.raleway(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
