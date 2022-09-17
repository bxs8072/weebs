import 'dart:async';
import 'dart:convert';
import 'package:freeforweebs/models/anime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteDatabase {
  final key = "FAVORITE";

  Future<List<Anime>> fetchAll() async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];
    return list.map((e) => Anime.fromMap(json.decode(e))).toList();
  }

  Future<bool> exist(Anime anime) async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];
    return list.contains(json.encode(anime.toMap));
  }

  Future<void> deleteAll() async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList(key, []);
  }

  Future<void> delete(String link) async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];
    list.removeWhere((e) => json.decode(e)["link"] == link);
    pref.setStringList(key, list);
  }

  Future<void> add(Anime anime) async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];

    bool isExist = await exist(anime);

    if (!isExist) {
      list.add(json.encode(anime.toMap));
      pref.setStringList(key, list);
    }
  }
}

class FavoriteBloc {
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  Stream<bool> get stream => _controller.stream.asBroadcastStream();

  Future<void> addAndUpdate(Anime anime) async {
    await FavoriteDatabase().add(anime).then(
        (value) => update(anime).then((value) => favoriteListBloc.update()));
  }

  Future<void> deleteAndUpdate(Anime anime) async {
    await FavoriteDatabase().delete(anime.link).then(
        (value) => update(anime).then((value) => favoriteListBloc.update()));
  }

  Future<void> update(Anime anime) async {
    FavoriteDatabase()
        .exist(anime)
        .then((exist) => _controller.sink.add(exist));
  }
}

class FavoriteListBloc {
  final StreamController<List<Anime>> _controller =
      StreamController<List<Anime>>.broadcast();

  Stream<List<Anime>> get stream => _controller.stream.asBroadcastStream();
  deleteAllAndUpdate() async {
    await FavoriteDatabase()
        .deleteAll()
        .then((value) => favoriteListBloc.update());
  }

  update() {
    FavoriteDatabase().fetchAll().then((list) => _controller.sink.add(list));
  }
}

final FavoriteBloc favoriteBloc = FavoriteBloc();

final FavoriteListBloc favoriteListBloc = FavoriteListBloc();
