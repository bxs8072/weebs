import 'package:flutter/material.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/grid_builder.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/search_ui/search_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

class SearchUI extends StatefulWidget {
  final Person person;
  const SearchUI({Key? key, required this.person}) : super(key: key);

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  final SearchBloc bloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  "Search",
                  style: GoogleFonts.lato(),
                ),
                backgroundColor: ThemeTool(context).isDark
                    ? AppTheme.dark().data.scaffoldBackgroundColor
                    : AppTheme.purple().data.scaffoldBackgroundColor,
                foregroundColor: ThemeTool(context).appBarForegroundColor,
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeTool(context).isDark
                        ? const Color(0xFF242424)
                        : const Color(0XFFE8EAED),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(0.0),
                      border: InputBorder.none,
                      labelText: "Search",
                      hintText: "Eg. Naruto",
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.purpleAccent,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          textEditingController.clear();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.clear,
                          color: ThemeTool(context).appBarForegroundColor,
                        ),
                      ),
                    ),
                    onChanged: (String? val) {
                      bloc.update(val!);
                      setState(() {});
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: Go(context).size.height * 0.03,
                ),
              ),
              StreamBuilder<List<Anime>>(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SliverToBoxAdapter();
                    } else {
                      List<Anime> list = snapshot.data!;
                      return GridBuilder(
                          key: widget.key, list: list, person: widget.person);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
