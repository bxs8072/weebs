import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freeforweebs/databases/favorite_database.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/anime_detail.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/app_drawer.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/anime_detail_ui/components/anime_detail_info.dart';
import 'package:freeforweebs/uis/anime_detail_ui/components/episode_ui.dart';

class AnimeDetailUI extends StatelessWidget {
  final Anime anime;
  final AnimeDetail animeDetail;
  final Person person;
  const AnimeDetailUI({
    Key? key,
    required this.anime,
    required this.animeDetail,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    favoriteBloc.update(anime);
    return Scaffold(
      endDrawer: AppDrawer(key: key, person: person),
      floatingActionButton: StreamBuilder<bool>(
        stream: favoriteBloc.stream,
        initialData: false,
        builder: (context, snapshot) {
          bool exist = snapshot.data!;
          return FloatingActionButton(
            onPressed: () {
              if (exist) {
                favoriteBloc.deleteAndUpdate(anime).then((value) {
                  Fluttertoast.showToast(
                      msg: "${anime.title} Removed from Favorites");
                });
              } else {
                favoriteBloc.addAndUpdate(anime).then((value) {
                  Fluttertoast.showToast(
                      msg: "${anime.title} added to Favorites");
                });
              }
            },
            backgroundColor: Colors.black,
            child: Icon(
              exist ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          );
        },
      ),
      body: GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.00,
              leading: BackButton(key: key),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: ThemeTool(context).appBarForegroundColor,
              pinned: true,
              title: Text(anime.title),
            ),
            SliverToBoxAdapter(
              child: AnimeDetailInfo(
                  key: key,
                  anime: anime,
                  animeDetail: animeDetail,
                  person: person),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            EpisodeUI(
              key: key,
              anime: anime,
              animeDetail: animeDetail,
              person: person,
            ),
          ],
        ),
      ),
    );
  }
}
