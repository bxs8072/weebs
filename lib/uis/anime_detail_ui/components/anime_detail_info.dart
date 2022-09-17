import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/anime_detail.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/constant.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/anime_ui/anime_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeDetailInfo extends StatelessWidget {
  final Anime anime;
  final AnimeDetail animeDetail;
  final Person person;
  const AnimeDetailInfo({
    Key? key,
    required this.anime,
    required this.animeDetail,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Go(context).size.width,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black38, blurRadius: 10),
            ],
            image: DecorationImage(
              image: NetworkImage(
                anime.image,
              ),
              alignment: Alignment.center,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  ThemeTool(context).isDark
                      ? Colors.black.withOpacity(0.6)
                      : Colors.white.withOpacity(0.6),
                  BlendMode.darken),
            ),
          ),
          child: ClipRect(
            key: key,
            child: BackdropFilter(
              key: key,
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(anime.image),
                      radius: Go(context).size.height * 0.17,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      anime.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vollkorn(
                          fontSize: Go(context).size.height * 0.025),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: ThemeTool(context).isDark
                              ? const Color(0xFF242424)
                              : const Color(0XFFE8EAED),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Released", style: GoogleFonts.lato()),
                              Text(animeDetail.released,
                                  style: GoogleFonts.lato()),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Go(context).push(AnimeUI(
                            person: person,
                            type: "subcategory",
                            title: animeDetail.season,
                            value: animeDetail.season,
                            key: key,
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemeTool(context).isDark
                                ? const Color(0xFF242424)
                                : const Color(0XFFE8EAED),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Season", style: GoogleFonts.lato()),
                                Text(animeDetail.season,
                                    style: GoogleFonts.lato()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ThemeTool(context).isDark
                              ? const Color(0xFF242424)
                              : const Color(0XFFE8EAED),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("Status", style: GoogleFonts.lato()),
                              Text(animeDetail.status,
                                  style: GoogleFonts.lato()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Other Name: ${animeDetail.otherName}",
                    style: GoogleFonts.lato(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return Scaffold(
                              body: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "Story Plot: \n\n${animeDetail.description}",
                                  style: GoogleFonts.lato(
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Text(
                      "Show Story",
                      style: GoogleFonts.lato(
                        color: ThemeTool(context).isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Go(context).size.height * 0.06,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: animeDetail.genreList.length,
                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: true,
                        addSemanticIndexes: true,
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                Go(context).push(
                                  AnimeUI(
                                    person: person,
                                    type: "genre",
                                    title: animeDetail.genreList[i],
                                    value: animeDetail.genreList[i],
                                  ),
                                );
                              },
                              child: Text(
                                animeDetail.genreList[i],
                                style: GoogleFonts.lato(
                                  color: ThemeTool(context).isDark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
