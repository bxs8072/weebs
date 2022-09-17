import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/notification_ui/notification_ui.dart';
import 'package:freeforweebs/uis/search_ui/search_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAppbar extends StatelessWidget {
  final Person person;
  const DashboardAppbar({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      foregroundColor: ThemeTool(context).appBarForegroundColor,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      title: Text(
        "Weebs",
        style: GoogleFonts.pacifico(
          color: Colors.purple,
          fontSize: Go(context).appbarTitleSize,
          letterSpacing: 1.5,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Go(context).push(
              SearchUI(key: key, person: person),
            );
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Go(context).push(
              NotificationsUI(key: key, person: person),
            );
          },
          icon: const Icon(Icons.notifications),
        ),
      ],
    );
  }
}
