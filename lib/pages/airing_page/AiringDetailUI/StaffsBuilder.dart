import 'package:flutter/material.dart';
import 'package:freeforweebs/models/airing_anime_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffsBuilder extends StatelessWidget {
  final List<Staff> staffs;
  const StaffsBuilder({Key? key, required this.staffs}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Staffs",
              style: GoogleFonts.lato(
                  fontSize: MediaQuery.of(context).size.height * 0.03),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1,
                  crossAxisCount: 1),
              itemCount: staffs.length,
              itemBuilder: (context, i) {
                final staff = staffs[i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.07,
                          backgroundImage: NetworkImage(staff.image),
                        ),
                      ),
                    ),
                    Text(
                      "Role: " + staff.role,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                    Text(
                      staff.nodeName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.02),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
