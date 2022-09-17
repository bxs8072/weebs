import 'package:flutter/material.dart';
import 'package:freeforweebs/databases/favorite_database.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/grid_builder.dart';
import 'package:freeforweebs/resources/loading_page.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatelessWidget {
  final Person person;
  const FavoritePage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    favoriteListBloc.update();
    return StreamBuilder<List<Anime>>(
        stream: favoriteListBloc.stream,
        initialData: const <Anime>[],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingPage(key: key);
          }
          List<Anime> list = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  'Favorites',
                  style: GoogleFonts.lato(),
                ),
                foregroundColor: ThemeTool(context).appBarForegroundColor,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                pinned: true,
                actions: [
                  list.isEmpty
                      ? const Center()
                      : IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: Text(
                                      "Are you sure?",
                                      style: GoogleFonts.lato(),
                                    ),
                                    content: Text(
                                      "Do you want to clear your favorite list?",
                                      style: GoogleFonts.lato(),
                                    ),
                                    actions: [
                                      IconButton(
                                          onPressed: () {
                                            favoriteListBloc
                                                .deleteAllAndUpdate();
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.check_box)),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.cancel)),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.delete_forever),
                        ),
                ],
              ),
              list.isEmpty
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Go(context).size.height * 0.2,
                            ),
                            Icon(
                              Icons.favorite,
                              size: Go(context).size.height * 0.1,
                            ),
                            SizedBox(
                              height: Go(context).size.height * 0.05,
                            ),
                            Text(
                              "You have no favorites.",
                              style: GoogleFonts.lato(
                                  fontSize: Go(context).size.height * 0.03),
                            ),
                          ],
                        ),
                      ),
                    )
                  : GridBuilder(key: key, list: list, person: person),
            ],
          );
        });
  }
}
