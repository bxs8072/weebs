import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freeforweebs/models/airing_anime.dart';
import 'package:freeforweebs/models/airing_anime_detail.dart';
import 'package:freeforweebs/resources/constant.dart';
import 'package:http/http.dart' as http;

class AiringAnimeScrapper {
  Future<List<AiringAnime>> fetchAll() async {
    var response = await http.get(Uri.parse('${Constant.baseUrl}/airinganime'));
    var data = json.decode(response.body)['list'] as List;

    List<AiringAnime> items = data.map((e) {
      return AiringAnime(
        airingAt: Timestamp.fromMicrosecondsSinceEpoch(e['airingAt'].toInt()),
        countryOfOrigin: e['countryOfOrigin'] ?? "",
        coverImage: e['coverImage'] ?? "",
        description: e['description'] ?? "",
        episode: e['episode'] ?? 0,
        id: e['id'] ?? 0,
        nativetitle: e['nativetitle'] ?? "",
        title: e['title'] ?? "",
        duration: e['duration'] ?? 0,
        season: e['season'] ?? "",
        startDate: e['startDate'] ?? "",
        status: e['status'] ?? "",
        synonyms:
            List.from(e['synonyms'] ?? []).map((e) => e.toString()).toList(),
      );
    }).toList();

    return items;
  }

  Future<AiringAnimeDetail> fetch({required int id}) async {
    var response =
        await http.get(Uri.parse('${Constant.baseUrl}/airinganime/$id'));
    var data = json.decode(response.body)['data'];
    AiringAnimeDetail airingAnimeDetail = AiringAnimeDetail.fromDynamic(data);
    return airingAnimeDetail;
  }
}
