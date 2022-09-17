import 'dart:convert';

import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/anime_detail.dart';
import 'package:freeforweebs/resources/constant.dart';
import 'package:http/http.dart';

class AnimeDetailApi {
  Client http = Client();

  Uri uri(String url) => Uri.parse(url);

  Future<Response> responseByPost(Uri uri, Map<String, dynamic> body) async {
    return await http.post(uri, body: body);
  }

  Future<AnimeDetail> fetch({required Anime anime}) async {
    Response response = await responseByPost(
        uri("${Constant.baseUrl}/anime-detail"), {"link": anime.link});
    print(response.body);
    return AnimeDetail.fromMap(json.decode(response.body)["data"]);
  }
}
