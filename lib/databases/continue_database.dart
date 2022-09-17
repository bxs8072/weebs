import 'dart:async';
import 'dart:convert';

import 'package:freeforweebs/models/anime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContinueDatabase {
  static String key = "CONTINUE";
  Future<void> delete(String link) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

  Future<void> add(Anime anime) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(key, json.encode(anime.toMap));
  }

  Future<Anime> get() async {
    final pref = await SharedPreferences.getInstance();
    return Anime.fromMap(json.decode(pref.getString(key)!));
  }
}

class ContinueBloc {
  StreamController<Anime> controller = StreamController<Anime>.broadcast();

  Stream<Anime> get stream => controller.stream.asBroadcastStream();

  get dispose => controller.close();

  Future<void> addAndUpdate(Anime anime) async {
    ContinueDatabase().add(anime).then((value) => continueBloc.update());
  }

  Future<void> update() async {
    ContinueDatabase().get().then((anime) => controller.sink.add(anime));
  }
}

final ContinueBloc continueBloc = ContinueBloc();
