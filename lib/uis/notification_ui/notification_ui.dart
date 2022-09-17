import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsUI extends StatefulWidget {
  final Person person;
  const NotificationsUI({Key? key, required this.person}) : super(key: key);

  @override
  NotificationsUIState createState() => NotificationsUIState();
}

class NotificationsUIState extends State<NotificationsUI> {
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: Text(
                  'Notifications',
                  style: GoogleFonts.lato(),
                ),
                foregroundColor: ThemeTool(context).appBarForegroundColor,
                backgroundColor: ThemeTool(context).isDark
                    ? AppTheme.dark().data.scaffoldBackgroundColor
                    : AppTheme.purple().data.scaffoldBackgroundColor,
                pinned: true,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Notifications")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: Go(context).size.height * 0.05,
                              ),
                              Icon(
                                Icons.notifications_none,
                                size: Go(context).size.height * 0.08,
                              ),
                              SizedBox(
                                height: Go(context).size.height * 0.03,
                              ),
                              Text(
                                "No Notifications Found",
                                style: GoogleFonts.lato(
                                    fontSize: Go(context).size.height * 0.025),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      List<Map<String, dynamic>> items = snapshot.data!.docs
                          .map((e) => e.data() as Map<String, dynamic>)
                          .toList();
                      if (items.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Go(context).size.height * 0.05,
                                ),
                                Icon(
                                  Icons.notifications_none,
                                  size: Go(context).size.height * 0.08,
                                ),
                                SizedBox(
                                  height: Go(context).size.height * 0.03,
                                ),
                                Text(
                                  "No Notifications Found",
                                  style: GoogleFonts.lato(
                                      fontSize:
                                          Go(context).size.height * 0.025),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, i) {
                          Map<String, dynamic> each = items[i];
                          return Card(
                            child: Padding(
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
                                      : Image.network(each['image']),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      each['content'],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(),
                                    ),
                                  ),
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
                                        ),
                                ],
                              ),
                            ),
                          );
                        }, childCount: items.length),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
