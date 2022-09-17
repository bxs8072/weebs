import 'package:flutter/material.dart';
import 'package:freeforweebs/models/airing_anime_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class CharactersBuilder extends StatelessWidget {
  final List<Character> characters;
  const CharactersBuilder({Key? key, required this.characters})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Characters",
              style: GoogleFonts.lato(
                  fontSize: MediaQuery.of(context).size.height * 0.03),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1,
                  crossAxisCount: 1),
              itemCount: characters.length,
              itemBuilder: (context, i) {
                final character = characters[i];
                return Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.07,
                          backgroundImage: NetworkImage(character.image),
                        ),
                      ),
                    ),
                    Text("Role: " + character.role)
                  ],
                );
              }),
        ),
      ],
    );
  }
}
