import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_ui/anime_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTile extends StatelessWidget {
  final Person person;
  final Widget icon;
  final String title;
  final String value;
  final String type;
  const CustomTile({
    Key? key,
    required this.person,
    required this.icon,
    required this.type,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Go(context).push(
          AnimeUI(
            person: person,
            value: value,
            type: type,
            title: title,
          ),
        );
      },
      child: SizedBox(
        width: Go(context).size.width * 0.35,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                Text(
                  title,
                  style: GoogleFonts.lato(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
