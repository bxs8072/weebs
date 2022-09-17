import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/pages/latest_page/latest_tile.dart';
import 'package:freeforweebs/pages/latest_page/latest_tile_builder.dart';
import 'package:freeforweebs/resources/constant.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestPage extends StatelessWidget {
  final Person person;
  const LatestPage({
    Key? key,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            'Latest',
            style: GoogleFonts.lato(),
          ),
          foregroundColor: ThemeTool(context).appBarForegroundColor,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          pinned: true,
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              LatestTile(
                key: key,
                person: person,
                type: "sub",
                value: "sub",
                title: "Latest Sub",
                subTitle: "Latest English Subbed Anime",
                color: Colors.blue,
                iconData: Icons.subtitles,
              ),
              LatestTileBuilder(key: key, person: person, type: "sub"),
              const Divider(thickness: 2),
              LatestTile(
                key: key,
                person: person,
                type: "dub",
                value: "dub",
                title: "Latest Dub",
                subTitle: "Latest English Dubbed Anime",
                color: Colors.green,
                iconData: Icons.language,
              ),
              LatestTileBuilder(key: key, person: person, type: "dub"),
              const Divider(thickness: 2),
              LatestTile(
                key: key,
                person: person,
                value: "chinese",
                type: "chinese",
                title: "Latest Chinese Anime",
                subTitle: "Latest Chinese Dubbed Anime",
                color: Colors.purple,
                iconData: Icons.translate,
              ),
              LatestTileBuilder(key: key, person: person, type: "chinese"),
            ],
          ),
        ),
      ],
    );
  }
}
