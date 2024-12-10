import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CatAd extends StatelessWidget {
  const CatAd({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrlString(
        'https://play.google.com/apps/testing/com.promaxbiz.chain_activities',
      ),
      child: Container(
        padding: const EdgeInsets.all(50.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.center,
            colors: [
              Colors.amber,
              Colors.lightGreen,
            ],
          ),
        ),
        child: Row(
          children: [
            Image.asset(assetMap["appCatLogo"]!),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tired of juggling tasks and losing track of time?",
                  style: GoogleFonts.prociono(
                    color: Colors.amber,
                    fontSize:
                        Theme.of(context).textTheme.displaySmall!.fontSize,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.android,
                  size: 100,
                ),
                Text(
                  "Try CAT.. an Android App",
                  style: GoogleFonts.protestGuerrilla(
                    color: Colors.black,
                    fontSize:
                        Theme.of(context).textTheme.displayLarge!.fontSize,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Your Personal Customizable",
                  style: GoogleFonts.prociono(
                    color: Colors.amber,
                    fontSize:
                        Theme.of(context).textTheme.displayMedium!.fontSize,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Time Management Tool.",
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
