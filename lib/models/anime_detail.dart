import 'package:freeforweebs/models/episode.dart';

class AnimeDetail {
  final String description, released, status, season, otherName;
  final List<String> genreList;
  final List<Episode> episodeList;

  AnimeDetail({
    required this.description,
    required this.released,
    required this.status,
    required this.season,
    required this.otherName,
    required this.genreList,
    required this.episodeList,
  });

  Map<String, dynamic> get toMap => {
        "description": description,
        "released": released,
        "status": status,
        "season": season,
        "otherName": otherName,
        "genreList": genreList,
        "episodeList": episodeList.map((e) => e.toMap).toList(),
      };

  factory AnimeDetail.fromMap(dynamic data) => AnimeDetail(
        description: data["plot"],
        released: data["released"],
        status: data["status"],
        season: data["type"],
        otherName: data["other"],
        genreList: List.from(data['genres']).map((e) => e.toString()).toList(),
        episodeList:
            List.from(data["episodes"]).map((e) => Episode.fromMap(e)).toList(),
      );
}
