import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:freeforweebs/apis/anime_api.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_detail_ui/anime_detail_ui_landing.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestTileBuilder extends StatelessWidget {
  final Person person;
  final String type;
  LatestTileBuilder({Key? key, required this.person, required this.type})
      : super(key: key);

  final AnimeApi animeApi = AnimeApi();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Go(context).size.height * 0.4,
      child: FutureBuilder<List<Anime>>(
          future: animeApi.fetchLatestAnime(type: type, page: 1),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Anime> list = snapshot.data!;
            return CarouselSlider(
                items: list.map((anime) {
                  return Builder(
                    builder: (BuildContext context) {
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
                  );
                }).toList(),
                options: CarouselOptions(
                  height: Go(context).size.height * 0.5,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.5,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                ));
          }),
    );
  }
}
