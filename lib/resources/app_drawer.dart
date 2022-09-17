import 'package:flutter/material.dart';
import 'package:freeforweebs/apis/auth.dart';
import 'package:freeforweebs/apis/notification_service.dart';
import 'package:freeforweebs/main.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/history_ui/history_ui.dart';
import 'package:freeforweebs/uis/notification_ui/notification_ui.dart';
import 'package:freeforweebs/uis/search_ui/search_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawer extends StatelessWidget {
  final Person person;
  const AppDrawer({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    notificationService.update();

    return Drawer(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: BackButton(key: key),
              title: Text(
                "HiStorm",
                style: GoogleFonts.lato(),
              ),
              foregroundColor: ThemeTool(context).appBarForegroundColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              pinned: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (ctx) {
                        return Weebs(key: key);
                      }));
                    },
                    icon: const Icon(Icons.dashboard)),
                IconButton(
                  onPressed: () {
                    Go(context).push(
                      SearchUI(person: person, key: key),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.purpleAccent,
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: ThemeTool(context).isDark
                          ? const Color(0xFF242424)
                          : const Color(0XFFE8EAED),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      leading: const Card(
                        color: Colors.black,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.dark_mode,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        "Dark Mode",
                        style: GoogleFonts.lato(),
                      ),
                      subtitle: Text(
                        "Change Theme",
                        style: GoogleFonts.lato(),
                      ),
                      trailing: Switch(
                        activeColor: Colors.blue,
                        onChanged: (val) {
                          ThemeTool(context).switchTheme;
                        },
                        value: ThemeTool(context).isDark,
                      ),
                    ),
                  ),
                  StreamBuilder<bool>(
                      stream: notificationService.stream,
                      initialData: false,
                      builder: (context, snapshot) {
                        bool isAll = snapshot.data!;
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: ThemeTool(context).isDark
                                ? const Color(0xFF242424)
                                : const Color(0XFFE8EAED),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ListTile(
                            leading: const Card(
                              color: Colors.red,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.add_alert,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(
                              "New Episode Alert",
                              style: GoogleFonts.lato(),
                            ),
                            subtitle: Text(
                              isAll ? "All Anime" : "Favorites Anime",
                              style: GoogleFonts.lato(),
                            ),
                            trailing: Switch(
                              activeColor: Colors.blue,
                              onChanged: (val) {
                                notificationService.setNotification(
                                    forAllAnime: val);
                              },
                              value: isAll,
                            ),
                          ),
                        );
                      }),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: ThemeTool(context).isDark
                          ? const Color(0xFF242424)
                          : const Color(0XFFE8EAED),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      onTap: (() => Go(context)
                          .push(HistoryUI(key: key, person: person))),
                      leading: const Card(
                        color: Colors.purple,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.history,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        "History",
                        style: GoogleFonts.lato(),
                      ),
                      subtitle: Text(
                        "Check your history",
                        style: GoogleFonts.lato(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: ThemeTool(context).isDark
                          ? const Color(0xFF242424)
                          : const Color(0XFFE8EAED),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      onTap: (() => Go(context).push(NotificationsUI(
                            key: key,
                            person: person,
                          ))),
                      leading: const Card(
                        color: Colors.blue,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        "Notifications",
                        style: GoogleFonts.lato(),
                      ),
                      subtitle: Text(
                        "Get Updates and News",
                        style: GoogleFonts.lato(),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: ThemeTool(context).isDark
                          ? const Color(0xFF242424)
                          : const Color(0XFFE8EAED),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text(
                                  "Are you sure?",
                                  style: GoogleFonts.lato(),
                                ),
                                content: Text(
                                  "Do you want to logout?",
                                  style: GoogleFonts.lato(),
                                ),
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        Auth().logout();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.check_box)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.cancel))
                                ],
                              );
                            });
                      },
                      leading: const Card(
                        color: Colors.teal,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Text(
                        "Logout",
                        style: GoogleFonts.lato(),
                      ),
                      subtitle: Text(
                        "Sign out from the app",
                        style: GoogleFonts.lato(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
