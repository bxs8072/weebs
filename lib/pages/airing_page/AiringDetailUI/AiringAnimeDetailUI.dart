import 'package:flutter/material.dart';
import 'package:freeforweebs/resources/loading_page.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freeforweebs/apis/airing_anime_scrapper.dart';
import 'package:freeforweebs/models/airing_anime.dart';
import 'package:freeforweebs/models/airing_anime_detail.dart';
import 'package:freeforweebs/pages/airing_page/AiringDetailUI/CharactersBuilder.dart';
import 'package:freeforweebs/pages/airing_page/AiringDetailUI/Header.dart';
import 'package:freeforweebs/pages/airing_page/AiringDetailUI/StaffsBuilder.dart';
import 'package:freeforweebs/pages/airing_page/AiringDetailUI/StudioBuilder.dart';
import 'package:intl/intl.dart';
import 'package:theme_provider/theme_provider.dart';

class AiringAnimeDetailUI extends StatefulWidget {
  final AiringAnime airingAnime;
  final int id;
  const AiringAnimeDetailUI(
      {Key? key, required this.id, required this.airingAnime})
      : super(key: key);

  @override
  AiringAnimeDetailUIState createState() => AiringAnimeDetailUIState();
}

class AiringAnimeDetailUIState extends State<AiringAnimeDetailUI> {
  AiringAnimeScrapper scrapper = AiringAnimeScrapper();
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        body: FutureBuilder<AiringAnimeDetail>(
            future: scrapper.fetch(id: widget.id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingPage(key: widget.key);
              }
              AiringAnimeDetail airingAnimeDetail = snapshot.data!;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      widget.airingAnime.title,
                      style: GoogleFonts.lato(),
                    ),
                    foregroundColor: ThemeTool(context).appBarForegroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    pinned: true,
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Header(airingAnime: widget.airingAnime),
                        Center(
                          child: Text(
                            "${DateFormat('EEEE').format(widget.airingAnime.airingAt.toDate())} at ${DateFormat().add_jm().format(widget.airingAnime.airingAt.toDate())}",
                            style: GoogleFonts.lato(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "${airingAnimeDetail.timeUntilAiring} left",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "NEXT AIRING: EPISODE ${airingAnimeDetail.nextAiringEpisode}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "DURATION",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ),
                                  Text(
                                    "${widget.airingAnime.duration} minutes",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "COUNTRY",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ),
                                  Text(
                                    widget.airingAnime.countryOfOrigin,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "SEASON",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ),
                                  Text(
                                    widget.airingAnime.season,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.airingAnime.description,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                          ),
                        ),
                        widget.airingAnime.synonyms.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "SYNONYMS: ${widget.airingAnime.synonyms}",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w800,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "STATUS",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ),
                                  Text(
                                    widget.airingAnime.status,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "EPISODE",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ),
                                  Text(
                                    "${widget.airingAnime.episode} episodes",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "START DATE",
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ),
                                  Text(
                                    widget.airingAnime.startDate,
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        airingAnimeDetail.characterList.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CharactersBuilder(
                                  characters: airingAnimeDetail.characterList,
                                ),
                              ),
                        airingAnimeDetail.staffList.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StaffsBuilder(
                                  staffs: airingAnimeDetail.staffList,
                                ),
                              ),
                        airingAnimeDetail.studioList.isEmpty
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: StudioBuilder(
                                  studios: airingAnimeDetail.studioList,
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
