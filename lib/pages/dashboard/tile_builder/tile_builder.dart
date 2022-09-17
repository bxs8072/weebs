import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/pages/dashboard/tile_builder/custom_tile.dart';
import 'package:freeforweebs/resources/constant.dart';
import 'package:freeforweebs/resources/go.dart';

class TileBuilder extends StatelessWidget {
  final Person person;
  const TileBuilder({Key? key, required this.person}) : super(key: key);

  List<CustomTile> get tiles => [
        CustomTile(
          person: person,
          icon: const Icon(Icons.monitor_heart_outlined),
          type: "type",
          value: "popular",
          title: "Popular",
        ),
        CustomTile(
          person: person,
          icon: const Icon(Icons.movie),
          type: "type",
          value: "anime movies",
          title: "Movies",
        ),
        CustomTile(
          person: person,
          icon: const Icon(Icons.new_releases),
          type: "type",
          value: "new season",
          title: "New Season",
        ),
        CustomTile(
          person: person,
          icon: const Icon(Icons.ondemand_video),
          type: "dub",
          value: "dub",
          title: "Dub",
        ),
        CustomTile(
          person: person,
          icon: const Icon(Icons.ondemand_video),
          type: "subcategory",
          value: "ova",
          title: "OVA",
        ),
        CustomTile(
          person: person,
          icon: const Icon(Icons.flash_on_sharp),
          type: "subcategory",
          value: "ona",
          title: "ONA",
        ),
        CustomTile(
          person: person,
          icon: const Icon(Icons.tv),
          type: "subcategory",
          value: "tv series",
          title: "TV Series",
        ),
        CustomTile(
          person: person,
          icon: const Icon(Icons.star),
          type: "subcategory",
          value: "special",
          title: "Special",
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Go(context).size.height * 0.12,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tiles.length,
          itemBuilder: (ctx, i) {
            return tiles[i];
          }),
    );
  }
}
