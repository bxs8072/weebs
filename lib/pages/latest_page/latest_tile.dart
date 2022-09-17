import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_ui/anime_ui.dart';
import 'package:freeforweebs/uis/latest_anime_ui/latest_anime_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestTile extends StatelessWidget {
  final Person person;
  final String type, value;
  final String title, subTitle;
  final IconData iconData;
  final Color color;
  const LatestTile({
    Key? key,
    required this.person,
    required this.type,
    required this.value,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Go(context).push(
        LatestAnimeUI(person: person, type: type, title: title),
      ),
      leading: Card(
        color: color,
        shape: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            iconData,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.lato(),
      ),
      subtitle: Text(
        subTitle,
        style: GoogleFonts.lato(),
      ),
      trailing: const Icon(
        Icons.forward,
        color: Colors.white,
      ),
    );
  }
}
