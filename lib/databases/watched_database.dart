import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class WatchedDatabase {
  static const key = "WATCHED_LIST";

  Future<List<String>> fetchAll() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList(key) ?? [];
  }

  Future<void> deleteAll() async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList(key, []);
  }

  Future<void> delete(String link) async {
    final pref = await SharedPreferences.getInstance();
    List<String> strList = pref.getStringList(key) ?? [];
    strList.removeWhere((e) => e == link);
    pref.setStringList(key, strList);
  }

  Future<void> add(String link) async {
    final pref = await SharedPreferences.getInstance();
    List<String> strList = pref.getStringList(key) ?? [];

    if (!strList.contains(link)) strList.add(link);

    pref.setStringList(key, strList);
  }
}

class WatchedListBloc {
  final StreamController<List<String>> _controller =
      StreamController<List<String>>.broadcast();
  Stream<List<String>> get stream => _controller.stream.asBroadcastStream();

  addAndUpdate(String link) async {
    WatchedDatabase().add(link).then((value) => update());
  }

  removeAndUpdate(String link) async {
    WatchedDatabase().delete(link).then((value) => update());
  }

  update() async {
    WatchedDatabase().fetchAll().then((list) => _controller.sink.add(list));
  }
}

final WatchedListBloc watchedListBloc = WatchedListBloc();
