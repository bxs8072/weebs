import 'package:cloud_firestore/cloud_firestore.dart';

class AiringAnime {
  final int id, episode, duration;
  final Timestamp airingAt;
  final String startDate,
      status,
      season,
      title,
      nativetitle,
      countryOfOrigin,
      description,
      coverImage;

  final List<String> synonyms;

  AiringAnime({
    required this.id,
    required this.duration,
    required this.title,
    required this.nativetitle,
    required this.episode,
    required this.airingAt,
    required this.startDate,
    required this.status,
    required this.season,
    required this.countryOfOrigin,
    required this.description,
    required this.coverImage,
    required this.synonyms,
  });

  factory AiringAnime.fromDynamic(dynamic data) => AiringAnime(
        airingAt: Timestamp.fromMillisecondsSinceEpoch(
            int.parse(data['airingAt']) * 1000),
        countryOfOrigin: data['countryOfOrigin'],
        coverImage: data['coverImage'],
        description: data['description'],
        episode: data['episode'],
        id: data['id'],
        nativetitle: data['nativetitle'],
        title: data['title'],
        duration: data['duration'],
        season: data['season'],
        startDate: data['startDate'],
        status: data['status'],
        synonyms: List.from(data['synonyms']).map((e) => e.toString()).toList(),
      );
}
