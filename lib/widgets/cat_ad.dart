import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CatAd extends StatelessWidget {
  const CatAd({super.key});

  List<Widget> getAdContent(
      BuildContext context, double layoutWidth, double layoutHeight) {
    List<Widget> adContent = [
      Text(
        "Tired of juggling tasks and losing track of time?",
        textAlign: TextAlign.center,
        style: GoogleFonts.prociono(
          color: Colors.amberAccent,
          fontSize: layoutWidth * 0.02,
          //
        ),
      ),
      const Text(
        "Let's try",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        "C A T",
        textAlign: TextAlign.center,
        style: GoogleFonts.protestGuerrilla(
          fontSize: layoutWidth * 0.05,
          color: Colors.black87,
        ),
      ),
      const Text(
        "An Android App",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Icon(
        Icons.android,
        size: layoutWidth * 0.03,
      ),
      Text(
        "to Chain the Activities with Timers & Play it.",
        textAlign: TextAlign.center,
        style: GoogleFonts.protestGuerrilla(
          fontSize: layoutWidth * 0.02,
          color: Colors.amberAccent,
        ),
      ),
      Text(
        "Your Personal Customizable",
        textAlign: TextAlign.center,
        style: GoogleFonts.prociono(
          color: Colors.amberAccent,
          fontSize: layoutWidth * 0.02,
        ),
      ),
      Text(
        "Time Management Tool.",
        textAlign: TextAlign.center,
        style: GoogleFonts.prociono(
          color: Colors.amberAccent,
          fontSize: layoutWidth * 0.02,
        ),
      ),
    ];
    return adContent;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrlString(
        'https://play.google.com/apps/testing/com.promaxbiz.chain_activities',
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          return Container(
            padding: const EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.blueGrey.shade400,
                  if (boxConstraints.maxWidth < 500) Colors.black,
                ],
              ),
            ),
            child: (boxConstraints.maxWidth > 500)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (boxConstraints.maxWidth >
                          (boxConstraints.maxWidth * 0.3))
                        Image.asset(
                          assetMap["appCatLogo"]!,
                          fit: BoxFit.cover,
                          width: boxConstraints.maxWidth * 0.3,
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...getAdContent(context, boxConstraints.maxWidth,
                              boxConstraints.maxHeight)
                        ],
                      )
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (boxConstraints.maxWidth >
                            (boxConstraints.maxWidth * 0.3))
                          Image.asset(
                            assetMap["appCatLogo"]!,
                            fit: BoxFit.cover,
                            width: boxConstraints.maxWidth * 0.25,
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...getAdContent(
                                context,
                                boxConstraints.maxWidth * 2,
                                boxConstraints.maxHeight * 2)
                          ],
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
