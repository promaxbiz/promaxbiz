import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CppTutAd extends StatelessWidget {
  const CppTutAd({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrlString(
        'https://www.youtube.com/watch?v=rlkGLfckfbw&list=PL37BCDA148773FE6D',
      ),
      child: Container(
        padding: const EdgeInsets.all(50.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.center,
            colors: [
              Colors.blue,
              Colors.pink,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              assetMap["appBarBackground"]!,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Lots of C++ Tutorials",
                  style: GoogleFonts.prociono(
                    color: Colors.amber,
                    fontSize:
                        Theme.of(context).textTheme.displaySmall!.fontSize,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "but none of them are on Linux",
                  style: GoogleFonts.prociono(
                    color: Colors.amber,
                    fontSize:
                        Theme.of(context).textTheme.displaySmall!.fontSize,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "C++ Programming",
                  style: GoogleFonts.protestGuerrilla(
                    color: Colors.black,
                    fontSize:
                        Theme.of(context).textTheme.displayLarge!.fontSize,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Tutorial on Ubuntu Linux",
                  style: GoogleFonts.prociono(
                    color: Colors.amber,
                    fontSize:
                        Theme.of(context).textTheme.displayMedium!.fontSize,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
