import 'package:flutter/material.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/anime_detail.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/loading_page.dart';
import 'package:freeforweebs/uis/anime_detail_ui/anime_detail_bloc.dart';
import 'package:freeforweebs/uis/anime_detail_ui/anime_detail_ui.dart';
import 'package:theme_provider/theme_provider.dart';

class AnimeDetailUILanding extends StatelessWidget {
  final Anime anime;
  final Person person;
  AnimeDetailUILanding({
    Key? key,
    required this.anime,
    required this.person,
  }) : super(key: key);

  final AnimeDetailBloc bloc = AnimeDetailBloc();
  @override
  Widget build(BuildContext context) {
    bloc.update(anime);
    return ThemeConsumer(
      child: StreamBuilder<AnimeDetail>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingPage(key: key);
            }
            return AnimeDetailUI(
                key: key,
                anime: anime,
                animeDetail: snapshot.data!,
                person: person);
          }),
    );
  }
}
