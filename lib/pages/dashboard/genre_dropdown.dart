import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/constant.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/uis/anime_ui/anime_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreDropdown extends StatelessWidget {
  final Person person;
  const GenreDropdown({Key? key, required this.person}) : super(key: key);

  List<DropdownMenuItem<String>> get dropdownItems => Constant.genreList
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: GoogleFonts.lato(),
            ),
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(15.0),
      alignment: Alignment.center,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      hint: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Select Genre",
          style: GoogleFonts.lato(),
        ),
      ),
      items: dropdownItems,
      underline: const Center(),
      onChanged: (value) {
        Go(context).push(
          AnimeUI(
            person: person,
            title: value!,
            type: "genre",
            key: key,
            value: value,
          ),
        );
      },
    );
  }
}
