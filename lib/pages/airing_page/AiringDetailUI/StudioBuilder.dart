import 'package:flutter/material.dart';
import 'package:freeforweebs/models/airing_anime_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class StudioBuilder extends StatelessWidget {
  final List<Studio> studios;
  const StudioBuilder({Key? key, required this.studios}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Studios",
              style: GoogleFonts.lato(
                  fontSize: MediaQuery.of(context).size.height * 0.03),
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.1,
          ),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              primary: false,
              itemCount: studios.length,
              itemBuilder: (context, i) {
                final studio = studios[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          studio.nodeName,
                          style: GoogleFonts.lato(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025),
                        ),
                        Text(
                          studio.isMain ? "Main Studio" : "Supporting Studio",
                          style: GoogleFonts.lato(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
