import 'dart:async';

import 'package:freeforweebs/apis/anime_api.dart';
import 'package:freeforweebs/models/anime.dart';

class SearchBloc {
  final StreamController<List<Anime>> _controller =
      StreamController<List<Anime>>.broadcast();

  Stream<List<Anime>> get stream => _controller.stream.asBroadcastStream();

  AnimeApi animeApi = AnimeApi();

  Future<void> update(String query) async {
    animeApi
        .fetchAnimeByType(page: 1, type: "search", value: query)
        .then((list) => _controller.sink.add(list));
  }
}
