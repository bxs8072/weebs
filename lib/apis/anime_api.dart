import 'dart:convert';

import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/resources/constant.dart';
import 'package:http/http.dart';

class AnimeApi {
  Client http = Client();

  Uri uri(String url) => Uri.parse(url);

  Future<List<Anime>> fetchAnimeByType(
      {required String type, required String value, required int page}) async {
    Response response = await http.post(
      uri("${Constant.baseUrl}/anime"),
      body: {
        "type": type,
        "value": value,
        "page": page.toString(),
      },
    );

    print(response.body);

    List list = json.decode(response.body)['data'] as List;

    return list.map((e) => Anime.fromMap(e)).toList();
  }

  Future<List<Anime>> fetchLatestAnime(
      {required String type, required int page}) async {
    Response response = await http.post(
      uri("${Constant.baseUrl}/latest-anime"),
      body: {
        "type": type,
        "page": page.toString(),
      },
    );
    List list = json.decode(response.body)['data'] as List;

    return list.map((e) => Anime.fromMap(e)).toList();
  }
}
