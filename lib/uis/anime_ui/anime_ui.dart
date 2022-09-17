import 'package:flutter/material.dart';
import 'package:freeforweebs/models/anime.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/monetization/unity_ad_service.dart';
import 'package:freeforweebs/resources/app_drawer.dart';
import 'package:freeforweebs/resources/grid_builder.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/anime_ui/anime_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:theme_provider/theme_provider.dart';

class AnimeUI extends StatefulWidget {
  final Person person;
  final String title;
  final String value;
  final String type;
  const AnimeUI(
      {Key? key,
      required this.person,
      required this.type,
      required this.value,
      required this.title})
      : super(key: key);
  @override
  State<AnimeUI> createState() => _AnimeUIState();
}

class _AnimeUIState extends State<AnimeUI> {
  final AnimeBloc bloc = AnimeBloc();
  final ScrollController scrollController = ScrollController();

  int page = 1;

  initScroller() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          page++;
        });
        bloc.update(widget.type, page, widget.title);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    bloc.update(widget.type, page, widget.value);
    initScroller();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      key: widget.key,
      child: Scaffold(
        endDrawer: AppDrawer(key: widget.key, person: widget.person),
        body: CustomScrollView(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              leading: BackButton(key: widget.key),
              title: Text(
                widget.title,
                style: GoogleFonts.lato(),
              ),
              backgroundColor: ThemeTool(context).isDark
                  ? AppTheme.dark().data.scaffoldBackgroundColor
                  : AppTheme.purple().data.scaffoldBackgroundColor,
              foregroundColor: ThemeTool(context).appBarForegroundColor,
              pinned: true,
            ),
            StreamBuilder<List<Anime>>(
              stream: bloc.stream,
              builder: (ctx, snapshot) {
                if (!snapshot.hasData) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("Loading"),
                    ),
                  );
                }

                for (Anime x in snapshot.data!) {
                  if (!bloc.animeList.contains(x)) {
                    bloc.animeList.add(x);
                  }
                }

                return GridBuilder(
                    key: widget.key,
                    list: bloc.animeList,
                    person: widget.person);
              },
            ),
            const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
