import 'package:flutter/material.dart';
import 'package:freeforweebs/databases/history_database.dart';
import 'package:freeforweebs/models/history.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_detail_ui/anime_detail_ui_landing.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryListBuilder extends StatelessWidget {
  final List<History> list;
  final Person person;

  const HistoryListBuilder({Key? key, required this.list, required this.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          History history = list[i];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(history.anime.image)),
              title: Text(
                history.anime.title,
                style: GoogleFonts.lato(),
              ),
              subtitle: Text(
                history.episode.title,
                style: GoogleFonts.lato(),
              ),
              onTap: () {
                Go(context).push(AnimeDetailUILanding(
                  anime: history.anime,
                  person: person,
                  key: key,
                ));
              },
              trailing: IconButton(
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
                            "Do you want to remove ${history.anime.title} ${history.episode.title}?",
                            style: GoogleFonts.lato(),
                          ),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  historyListBloc.deleteAndUpdate(history);

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
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
        childCount: list.length,
      ),
    );
  }
}
