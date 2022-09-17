import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/pages/dashboard/continue_watching.dart';
import 'package:freeforweebs/pages/dashboard/dashboard_appbar.dart';
import 'package:freeforweebs/pages/dashboard/genre_dropdown.dart';
import 'package:freeforweebs/pages/dashboard/tile.dart';
import 'package:freeforweebs/pages/dashboard/tile_builder/tile_builder.dart';
import 'package:freeforweebs/pages/dashboard/trending_builder.dart';
import 'package:freeforweebs/resources/go.dart';

class Dashboard extends StatelessWidget {
  final Person person;
  const Dashboard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        DashboardAppbar(key: key, person: person),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Tile(
                key: key,
                icon: Icons.trending_up_sharp,
                iconBackgroundColor: Colors.purple,
                iconColor: Colors.white,
                title: "Trending now",
              ),
              TrendingBuilder(key: key, person: person),
              SizedBox(
                height: Go(context).size.height * 0.03,
              ),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.symmetric(
                      horizontal: Go(context).size.width * 0.25),
                  child: GenreDropdown(person: person, key: key)),
              const Divider(thickness: 0.5),
              Tile(
                key: key,
                icon: Icons.all_inclusive_sharp,
                iconBackgroundColor: Colors.green,
                iconColor: Colors.white,
                title: "Try some more",
              ),
              TileBuilder(person: person, key: key),
              const Divider(thickness: 0.5),
              Tile(
                key: key,
                icon: Icons.watch,
                iconBackgroundColor: Colors.blue,
                iconColor: Colors.white,
                title: "Continue Watching",
              ),
              ContinueWatching(key: key, person: person),
            ],
          ),
        ),
      ],
    );
  }
}
