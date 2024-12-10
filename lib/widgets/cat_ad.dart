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
        style: GoogleFonts.prociono(
          color: Colors.black,
          fontSize: layoutWidth * 0.02,
          //
        ),
      ),
      Icon(
        Icons.android,
        size: layoutWidth * 0.03,
      ),
      Text(
        "Try CAT.. an Android App",
        style: GoogleFonts.protestGuerrilla(
          color: Colors.amber,
          fontSize: layoutWidth * 0.04,
        ),
      ),
      Text(
        "Your Personal Customizable",
        style: GoogleFonts.prociono(
          color: Colors.black,
          fontSize: layoutWidth * 0.02,
        ),
      ),
      Text(
        "Time Management Tool.",
        style: GoogleFonts.prociono(
          color: Colors.black,
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
              gradient: (boxConstraints.maxWidth > 500)
                  ? const LinearGradient(
                      end: Alignment.center,
                      colors: [
                        Colors.amber,
                        Colors.lightGreen,
                      ],
                    )
                  : const RadialGradient(
                      colors: [
                        Colors.amber,
                        Colors.lightGreen,
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
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
          );
        },
      ),
    );
  }
}
