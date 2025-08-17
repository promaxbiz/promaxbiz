import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:promaxbiz/widgets/templates/product_description.dart';

class ChainPlayAd extends StatelessWidget {
  const ChainPlayAd({super.key});

  List<Widget> getContent(
      BuildContext context, double layoutWidth, double layoutHeight) {
    List<Widget> adContent = [
      Text(
        "Lots of Apps\nthat plays the Chain of Activities",
        style: GoogleFonts.prociono(
          color: Colors.yellowAccent,
          fontSize: layoutHeight > layoutWidth
              ? layoutHeight * 0.02
              : layoutWidth * 0.02,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "but None of them allows you\nto define your own.",
        style: GoogleFonts.prociono(
          color: Colors.yellowAccent,
          fontSize: layoutHeight > layoutWidth
              ? layoutHeight * 0.02
              : layoutWidth * 0.02,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "ChainPlay helps you",
        style: GoogleFonts.protestGuerrilla(
          color: Colors.black,
          fontSize: layoutHeight > layoutWidth
              ? layoutHeight * 0.03
              : layoutWidth * 0.03,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "to define your own chain of activities,",
        style: GoogleFonts.prociono(
          color: Colors.yellowAccent,
          fontSize: layoutHeight > layoutWidth
              ? layoutHeight * 0.02
              : layoutWidth * 0.02,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "Share them, Schedule them & Play them",
        style: GoogleFonts.protestGuerrilla(
          color: Colors.yellowAccent,
          fontSize: layoutHeight > layoutWidth
              ? layoutHeight * 0.02
              : layoutWidth * 0.02,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
      Text(
        "\nDownload from the Google Play Store store today\nTake a Look!",
        style: GoogleFonts.prociono(
          color: Colors.black,
          fontSize: layoutHeight > layoutWidth
              ? layoutHeight * 0.01
              : layoutWidth * 0.01,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    ];
    return adContent;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints boxConstraints) {
        return ProductDescription(
          slideShowHeight: boxConstraints.maxHeight,
          slideShowWidth: boxConstraints.maxWidth,
          productImage: assetMap['appChainPlayLogo']!,
          productName: "ChainPlay",
          productTagLine: "Chain The Activities, Play It",
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...getContent(
                  context, boxConstraints.maxWidth, boxConstraints.maxHeight)
            ],
          ),
        );
      },
    );
  }
}
