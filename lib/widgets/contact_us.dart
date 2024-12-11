import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promaxbiz/utils/constants.dart';

class Contact extends StatelessWidget {
  final double slideShowHeight, slideShowWidth;
  const Contact({
    super.key,
    required this.slideShowHeight,
    required this.slideShowWidth,
  });

  List<Widget> getContactContent(
      BuildContext context, double layoutWidth, double layoutHeight) {
    List<Widget> adContent = [
      Text(
        "Pro Max Biz",
        style: GoogleFonts.prociono(
          color: Colors.black,
          fontSize: layoutWidth * 0.03,
          //
        ),
      ),
      Text(
        "You can reach us ",
        style: GoogleFonts.protestGuerrilla(
          color: Colors.black,
          fontSize: layoutWidth * 0.03,
        ),
      ),
      Text(
        "Mobile/WhatsApp: +91 9953997705",
        style: GoogleFonts.prociono(
          color: Colors.black,
          fontSize: layoutWidth * 0.02,
        ),
      ),
      Text(
        "Email: promaxbizcare@gmail.com",
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
    return SizedBox(
      height: slideShowHeight,
      width: slideShowWidth,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          return Container(
            padding: const EdgeInsets.all(50.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                //end: Alignment.center,
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
                          assetMap["appProMaxBizLogo"]!,
                          fit: BoxFit.cover,
                          width: boxConstraints.maxWidth * 0.3,
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...getContactContent(context, boxConstraints.maxWidth,
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
                          assetMap["appProMaxBizLogo"]!,
                          fit: BoxFit.cover,
                          width: boxConstraints.maxWidth * 0.3,
                        ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...getContactContent(
                            context,
                            boxConstraints.maxWidth * 2.5,
                            boxConstraints.maxHeight * 2.5,
                          )
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
