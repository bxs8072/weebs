import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freeforweebs/models/person.dart';
import 'package:freeforweebs/resources/theme_tool.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theme_provider/theme_provider.dart';

class AddNotificationUI extends StatefulWidget {
  final Person person;
  final bool isAdmin;
  const AddNotificationUI(
      {Key? key, required this.isAdmin, required this.person})
      : super(key: key);

  @override
  State<AddNotificationUI> createState() => _AddNotificationUIState();
}

class _AddNotificationUIState extends State<AddNotificationUI> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController btnNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Scaffold(
        body: GestureDetector(
          onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                foregroundColor: ThemeTool(context).appBarForegroundColor,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Text(
                  "Add Notification",
                  style: GoogleFonts.lato(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: "Title",
                            ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: contentController,
                            decoration: const InputDecoration(
                              labelText: "Content",
                            ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: imageController,
                            decoration: const InputDecoration(
                              labelText: "Image",
                            ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: linkController,
                            decoration: const InputDecoration(
                              labelText: "Link",
                            ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: btnNameController,
                            decoration: const InputDecoration(
                              labelText: "Button Name",
                            ),
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection("Notifications")
                                  .doc()
                                  .set({
                                "title": titleController.text.trim(),
                                "content": contentController.text.trim(),
                                "image": imageController.text.trim(),
                                "link": linkController.text.trim(),
                                "btnName": btnNameController.text.trim(),
                              }).then((value) {
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Submit",
                              style: GoogleFonts.lato(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
