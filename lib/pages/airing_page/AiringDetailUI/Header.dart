import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:freeforweebs/models/airing_anime.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final AiringAnime airingAnime;
  const Header({Key? key, required this.airingAnime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: height / 3,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(airingAnime.coverImage),
                alignment: Alignment.center,
                fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  airingAnime.coverImage,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            airingAnime.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.vollkorn(fontSize: height * 0.03),
          ),
        ),
      ],
    );
  }
}
