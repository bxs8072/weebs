import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const String key = "NOTIFICATION";
  final StreamController<bool> controller = StreamController<bool>.broadcast();
  Stream<bool> get stream => controller.stream.asBroadcastStream();

  Future<bool> isAll() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(key) ?? false;
  }

  Future<void> setNotification({required bool forAllAnime}) async {
    final pref = await SharedPreferences.getInstance();
    if (forAllAnime) {
      await FirebaseMessaging.instance.subscribeToTopic('all');
      pref.setBool(key, true);
    } else if (!forAllAnime) {
      await FirebaseMessaging.instance.unsubscribeFromTopic('all');
      pref.setBool(key, false);
    }
    notificationService.update();
  }

  Future<void> subscribeToTopic(Anime anime) async {
    String topic = anime.title
        .replaceAll(RegExp(r'[^\w\s]+'), "")
        .split(' ')
        .join('')
        .toLowerCase();
    await FirebaseMessaging.instance.subscribeToTopic(topic);
    notificationService.update();
  }

  Future<void> unsubscribeFromTopic(Anime anime) async {
    String topic = anime.title
        .replaceAll(RegExp(r'[^\w\s]+'), "")
        .split(' ')
        .join('')
        .toLowerCase();
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    notificationService.update();
  }

  Future<void> update() async {
    await isAll().then((all) => controller.sink.add(all));
  }
}

final NotificationService notificationService = NotificationService();
