import 'package:flutter/material.dart';
import 'package:freeforweebs/apis/airing_anime_scrapper.dart';
import 'package:freeforweebs/models/airing_anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/pages/airing_page/AiringDetailUI/AiringAnimeDetailUI.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AiringPage extends StatelessWidget {
  final Person person;
  const AiringPage({Key? key, required this.person}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AiringAnime>>(
      future: AiringAnimeScrapper().fetchAll(),
      initialData: const <AiringAnime>[],
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        List<AiringAnime> items = snapshot.data!;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Airing Schedule',
                style: GoogleFonts.lato(),
              ),
              foregroundColor: ThemeTool(context).appBarForegroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                        onTap: () {
                          Go(context).push(AiringAnimeDetailUI(
                            id: items[i].id,
                            airingAnime: items[i],
                          ));
                        },
                        contentPadding: const EdgeInsets.all(12),
                        title: Image.network(
                          items[i].coverImage,
                          height: Go(context).size.height * 0.3,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${DateFormat('EEEE').format(items[i].airingAt.toDate())} at ${DateFormat().add_jm().format(items[i].airingAt.toDate())} ",
                                style: GoogleFonts.lato(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                items[i].title,
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                              ),
                            ),
                            items[i].title == items[i].nativetitle
                                ? const Center()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      items[i].nativetitle,
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                    ),
                                  ),
                            items[i].synonyms.isEmpty
                                ? Container()
                                : Text("Synonyms: ${items[i].synonyms}"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "STATUS",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        items[i].status,
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "EPISODE",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        items[i].episode.toString(),
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "START DATE",
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        items[i].startDate,
                                        style: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                  );
                },
                childCount: items.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
