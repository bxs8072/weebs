import 'dart:async';

import 'package:freeforweebs/apis/anime_detail_anime.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/anime_detail.dart';

class AnimeDetailBloc {
  final StreamController<AnimeDetail> _controller =
      StreamController<AnimeDetail>.broadcast();

  Stream<AnimeDetail> get stream => _controller.stream.asBroadcastStream();

  AnimeDetailApi animeDetailApi = AnimeDetailApi();
  update(Anime anime) async {
    animeDetailApi
        .fetch(anime: anime)
        .then((detail) => _controller.sink.add(detail));
  }
}
