import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:freeforweebs/apis/video_api.dart';
import 'package:freeforweebs/databases/continue_database.dart';
import 'package:freeforweebs/databases/history_database.dart';
import 'package:freeforweebs/databases/watched_database.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/anime_detail.dart';
import 'package:freeforweebs/models/episode.dart';
import 'package:freeforweebs/models/history.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/video_ui/video_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodeUI extends StatefulWidget {
  final Anime anime;
  final AnimeDetail animeDetail;
  final Person person;
  const EpisodeUI({
    Key? key,
    required this.anime,
    required this.animeDetail,
    required this.person,
  }) : super(key: key);

  @override
  State<EpisodeUI> createState() => _EpisodeUIState();
}

class _EpisodeUIState extends State<EpisodeUI> {
  TextEditingController textEditingController = TextEditingController();
  List<Episode> searchedList = [];

  void setSearchedList() {
    setState(() {
      searchedList = widget.animeDetail.episodeList
          .where((e) => e.title
              .toLowerCase()
              .contains(textEditingController.text.trim().toLowerCase()))
          .toList();
    });
  }

  bool reverse = true;

  toggleReverse() {
    setState(() {
      reverse = !reverse;
    });
  }

  @override
  Widget build(BuildContext context) {
    watchedListBloc.update();
    return SliverStickyHeader(
      header: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeTool(context).isDark
                          ? const Color(0xFF242424)
                          : const Color(0XFFE8EAED),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0.0),
                        border: InputBorder.none,
                        labelText: "Search",
                        hintText: "Eg. 7",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.purpleAccent,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            textEditingController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.clear,
                            color: ThemeTool(context).appBarForegroundColor,
                          ),
                        ),
                      ),
                      onChanged: (String? val) {
                        setSearchedList();
                      },
                    ),
                  ),
                ),
                IconButton(
                    onPressed: toggleReverse,
                    icon: Icon(
                        reverse ? Icons.arrow_upward : Icons.arrow_downward)),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
      sliver: StreamBuilder<List<String>>(
          stream: watchedListBloc.stream,
          initialData: const <String>[],
          builder: (context, snapshot) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  Episode episode = searchedList.isEmpty
                      ? reverse
                          ? widget.animeDetail.episodeList.reversed.toList()[i]
                          : widget.animeDetail.episodeList[i]
                      : reverse
                          ? searchedList.reversed.toList()[i]
                          : searchedList[i];

                  bool watched = snapshot.data!.contains(episode.link);

                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: ThemeTool(context).isDark
                          ? const Color(0xFF242424)
                          : const Color(0XFFE8EAED),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(
                            watched ? Icons.remove_red_eye : Icons.play_arrow),
                        onPressed: () async {
                          if (watched) {
                            watchedListBloc.removeAndUpdate(episode.link);
                          }
                        },
                      ),
                      onTap: () {
                        if (!watched) {
                          watchedListBloc.addAndUpdate(episode.link);
                        }
                        continueBloc.addAndUpdate(widget.anime).then((value) {
                          historyListBloc.addAndUpdate(
                              History(anime: widget.anime, episode: episode));
                          Go(context).push(
                            VideoUI(key: widget.key, episode: episode),
                          );
                        });
                      },
                      title: Text(
                        episode.title,
                        style: GoogleFonts.lato(),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          String downloadLink = await VideoApi()
                              .fetchDownload(link: episode.link);
                          await launch(downloadLink);
                        },
                        icon: const Icon(Icons.download),
                      ),
                      subtitle: Text(
                        watched ? "Watched" : widget.anime.title,
                      ),
                    ),
                  );
                },
                childCount: searchedList.isEmpty
                    ? widget.animeDetail.episodeList.length
                    : searchedList.length,
              ),
            );
          }),
    );
  }
}
