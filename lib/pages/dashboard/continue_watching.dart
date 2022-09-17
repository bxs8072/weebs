import 'package:flutter/material.dart';
import 'package:freeforweebs/databases/continue_database.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_detail_ui/anime_detail_ui_landing.dart';
import 'package:google_fonts/google_fonts.dart';

class ContinueWatching extends StatelessWidget {
  final Person person;
  const ContinueWatching({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    continueBloc.update();
    final size = MediaQuery.of(context).size;
    return StreamBuilder<Anime>(
        stream: continueBloc.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center();
          }
          Anime anime = snapshot.data!;
          return ListTile(
            onTap: () {
              Go(context)
                  .push(AnimeDetailUILanding(anime: anime, person: person));
            },
            title: Container(
              height: size.height * 0.35,
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  anime.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            subtitle: Text(
              anime.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(),
            ),
          );
        });
  }
}
