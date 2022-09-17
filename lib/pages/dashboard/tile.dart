import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tile extends StatelessWidget {
  final String title;
  final Color iconColor, iconBackgroundColor;
  final IconData icon;
  const Tile(
      {Key? key,
      required this.icon,
      required this.iconBackgroundColor,
      required this.iconColor,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Card(
        color: iconBackgroundColor,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.lato(),
      ),
    );
  }
}
