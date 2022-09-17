import 'dart:async';

import 'package:freeforweebs/apis/anime_api.dart';
import 'package:freeforweebs/models/anime.dart';

class AnimeBloc {
  final StreamController<List<Anime>> _controller =
      StreamController<List<Anime>>.broadcast();

  Stream<List<Anime>> get stream => _controller.stream.asBroadcastStream();

  AnimeApi animeApi = AnimeApi();

  List<Anime> animeList = [];

  Future<void> update(String type, int page, String value) async {
    animeApi
        .fetchAnimeByType(
          page: page,
          type: type,
          value: value,
        )
        .then((list) => _controller.sink.add(list));
  }
}
