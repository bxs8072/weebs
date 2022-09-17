import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/pages/airing_page/airing_page.dart';
import 'package:freeforweebs/pages/dashboard/dashboard.dart';
import 'package:freeforweebs/pages/favorite_page/favorite_page.dart';
import 'package:freeforweebs/pages/latest_page/latest_page.dart';
import 'package:freeforweebs/pages/setting_page/setting_page.dart';
import 'package:freeforweebs/resources/app_drawer.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_detail_ui/anime_detail_ui_landing.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  final Person person;
  const HomeScreen({Key? key, required this.person}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> get pages => [
        Dashboard(key: widget.key, person: widget.person),
        LatestPage(key: widget.key, person: widget.person),
        AiringPage(key: widget.key, person: widget.person),
        FavoritePage(key: widget.key, person: widget.person),
        SettingPage(key: widget.key, person: widget.person),
      ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: "Dashboard",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.new_releases),
      label: "Latest",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.air),
      label: "Airing",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Favorites",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ];
  int index = 0;

  @override
  void initState() {
    super.initState();

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
    //   Anime anime = Anime.fromMap(message?.data['data']);
    //   Go(context).push(
    //     AnimeDetailUILanding(
    //         anime: anime, person: widget.person, key: widget.key),
    //   );
    // });

    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((RemoteMessage? message) {
    //   Anime anime = Anime.fromMap(message?.data['data']);
    //   Go(context).push(
    //     AnimeDetailUILanding(
    //         anime: anime, person: widget.person, key: widget.key),
    //   );
    // });
    // FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
    //   Anime anime = Anime.fromMap(message?.data['data']);
    //   Go(context).push(
    //     AnimeDetailUILanding(
    //         anime: anime, person: widget.person, key: widget.key),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(key: widget.key, person: widget.person),
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Alerts')
              //v1
              .doc('v2')
              .snapshots(),
          builder: (context, alertsnapshot) {
            if (!alertsnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!alertsnapshot.data!.exists) {
              return pages[index];
            } else if (alertsnapshot.data!.exists) {
              Map<String, dynamic> each =
                  alertsnapshot.data!.data() as Map<String, dynamic>;
              return AlertDialog(
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          each['title'],
                          style: GoogleFonts.lato(),
                        ),
                      ),
                      each['image'] == ""
                          ? const Center()
                          : each['image'] ?? Image.network(each['image']),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          each['content'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  each['btnName'] == ""
                      ? const Center()
                      : ElevatedButton(
                          onPressed: () async {
                            await launch(each['link']);
                          },
                          child: Text(
                            each['btnName'],
                            style: GoogleFonts.lato(),
                          ),
                        )
                ],
              );
            }
            return pages[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: items,
      ),
    );
  }
}
