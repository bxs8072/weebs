import 'dart:async';
import 'dart:convert';
import 'package:freeforweebs/models/history.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryDatabase {
  final key = "HISTORY";

  Future<List<History>> fetchAll() async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];
    return list
        .map((e) => History.fromMap(json.decode(e)))
        .toList()
        .reversed
        .toList();
  }

  Future<bool> exist(History history) async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];

    for (String x in list) {
      if (json.decode(x)["episode"]["link"] == history.episode.link) {
        return true;
      }
    }
    return false;
  }

  Future<void> deleteAll() async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList(key, []);
  }

  Future<void> delete(History history) async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];
    list.removeWhere(
        (e) => json.decode(e)["episode"]["link"] == history.episode.link);
    pref.setStringList(key, list);
  }

  Future<void> add(History history) async {
    final pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(key) ?? [];

    bool isExist = await exist(history);

    if (isExist) {
      list.removeWhere(
          (e) => json.decode(e)["episode"]["link"] == history.episode.link);
      list.add(json.encode(history.toMap));
      pref.setStringList(key, list);
    } else {
      list.add(json.encode(history.toMap));
      pref.setStringList(key, list);
    }
  }
}

class HistoryListBloc {
  final StreamController<List<History>> _controller =
      StreamController<List<History>>.broadcast();

  Stream<List<History>> get stream => _controller.stream.asBroadcastStream();
  Future<void> deleteAllAndUpdate() async {
    await HistoryDatabase()
        .deleteAll()
        .then((value) => historyListBloc.update());
  }

  Future<void> deleteAndUpdate(History history) async {
    await HistoryDatabase()
        .delete(history)
        .then((value) => historyListBloc.update());
  }

  Future<void> addAndUpdate(History history) async {
    await HistoryDatabase()
        .add(history)
        .then((value) => historyListBloc.update());
  }

  Future<void> update() async {
    HistoryDatabase().fetchAll().then((list) => _controller.sink.add(list));
  }
}

final HistoryListBloc historyListBloc = HistoryListBloc();
