import 'package:flutter/material.dart';
import 'package:freeforweebs/databases/history_database.dart';
import 'package:freeforweebs/models/history.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/app_drawer.dart';
import 'package:freeforweebs/resources/go.dart';
import 'package:freeforweebs/resources/loading_page.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:freeforweebs/uis/history_ui/history_list_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

class HistoryUI extends StatelessWidget {
  final Person person;
  const HistoryUI({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    historyListBloc.update();
    return ThemeConsumer(
      child: Scaffold(
        endDrawer: AppDrawer(key: key, person: person),
        body: StreamBuilder<List<History>>(
            stream: historyListBloc.stream,
            initialData: const <History>[],
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return LoadingPage(key: key);
              }
              List<History> list = snapshot.data!;

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: BackButton(key: key),
                    title: Text(
                      'History',
                      style: GoogleFonts.lato(),
                    ),
                    foregroundColor: ThemeTool(context).appBarForegroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    pinned: true,
                    actions: [
                      list.isEmpty
                          ? const Center()
                          : IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: Text(
                                          "Are you sure?",
                                          style: GoogleFonts.lato(),
                                        ),
                                        content: Text(
                                          "Do you want to clear your history list?",
                                          style: GoogleFonts.lato(),
                                        ),
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                historyListBloc
                                                    .deleteAllAndUpdate();
                                                Navigator.pop(context);
                                              },
                                              icon:
                                                  const Icon(Icons.check_box)),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.cancel)),
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.delete_forever),
                            ),
                    ],
                  ),
                  list.isEmpty
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: Go(context).size.height * 0.2,
                                ),
                                Icon(
                                  Icons.history,
                                  size: Go(context).size.height * 0.1,
                                ),
                                SizedBox(
                                  height: Go(context).size.height * 0.05,
                                ),
                                Text(
                                  "You have no History.",
                                  style: GoogleFonts.lato(
                                      fontSize: Go(context).size.height * 0.03),
                                ),
                              ],
                            ),
                          ),
                        )
                      : HistoryListBuilder(
                          key: key, list: list, person: person),
                ],
              );
            }),
      ),
    );
  }
}
