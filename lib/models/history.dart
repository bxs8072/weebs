import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/episode.dart';

class History {
  final Anime anime;
  final Episode episode;

  History({
    required this.anime,
    required this.episode,
  });

  Map<String, dynamic> get toMap => {
        "anime": anime.toMap,
        "episode": episode.toMap,
      };

  factory History.fromMap(dynamic data) => History(
        anime: Anime.fromMap(data["anime"]),
        episode: Episode.fromMap(data["episode"]),
      );
}
