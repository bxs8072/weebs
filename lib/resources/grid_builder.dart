import 'package:flutter/material.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_detail_ui/anime_detail_ui_landing.dart';
import 'package:google_fonts/google_fonts.dart';

class GridBuilder extends StatelessWidget {
  final List<Anime> list;
  final Person person;

  const GridBuilder({Key? key, required this.list, required this.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, i) {
            Anime anime = list[i];
            return GestureDetector(
              onTap: () {
                Go(context).push(AnimeDetailUILanding(
                  anime: anime,
                  person: person,
                  key: key,
                ));
              },
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        anime.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      anime.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.lato(),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: list.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.6,
        ),
      ),
    );
  }
}
