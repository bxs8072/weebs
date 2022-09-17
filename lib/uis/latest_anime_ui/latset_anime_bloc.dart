import 'dart:async';

import 'package:freeforweebs/apis/anime_api.dart';
import 'package:freeforweebs/models/anime.dart';

class LatestAnimeBloc {
  final StreamController<List<Anime>> _controller =
      StreamController<List<Anime>>.broadcast();

  Stream<List<Anime>> get stream => _controller.stream.asBroadcastStream();

  AnimeApi animeApi = AnimeApi();

  List<Anime> animeList = [];

  Future<void> update(String type, int page) async {
    animeApi
        .fetchLatestAnime(page: page, type: type)
        .then((list) => _controller.sink.add(list));
  }
}
