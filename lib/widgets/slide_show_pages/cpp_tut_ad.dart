import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:promaxbiz/widgets/templates/product_description.dart';

class CppTutAd extends StatelessWidget {
  const CppTutAd({super.key});

  List<Widget> getAdContent(
      BuildContext context, double layoutWidth, double layoutHeight) {
    List<Widget> adContent = [
      Text(
        "Lots of C++ Tutorials",
        style: GoogleFonts.prociono(
          color: Colors.yellowAccent,
          fontSize: layoutWidth * 0.02,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        "but none of them are on Linux",
        style: GoogleFonts.prociono(
          color: Colors.yellowAccent,
          fontSize: layoutWidth * 0.02,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        "C++ Programming",
        style: GoogleFonts.protestGuerrilla(
          color: Colors.black,
          fontSize: layoutWidth * 0.03,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(
        "Tutorial on Ubuntu Linux",
        style: GoogleFonts.prociono(
          color: Colors.yellowAccent,
          fontSize: layoutWidth * 0.02,
          letterSpacing: 3,
          fontWeight: FontWeight.w500,
        ),
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
        productImage: assetMap['tutCppLogo']!,
        productName: "C++ Programming",
        productTagLine: "Tutorial on Ubuntu Linux",
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...getAdContent(
                context, boxConstraints.maxWidth, boxConstraints.maxHeight)
          ],
        ),
      );
      // return Container(
      //   padding: const EdgeInsets.all(50.0),
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: (boxConstraints.maxWidth < 500)
      //           ? Alignment.topCenter
      //           : Alignment.centerLeft,
      //       end: (boxConstraints.maxWidth < 500)
      //           ? Alignment.bottomCenter
      //           : Alignment.centerRight,
      //       colors: [
      //         Theme.of(context).primaryColor,
      //         Theme.of(context).colorScheme.secondary,
      //         // if (boxConstraints.maxWidth < 500) Colors.black,
      //       ],
      //     ),
      //   ),
      //   child: (boxConstraints.maxWidth > 500)
      //       ? Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             Image.asset(
      //               assetMap["tutCppLogo"]!,
      //               width: boxConstraints.maxWidth * 0.3,
      //             ),
      //             Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 ...getAdContent(context, boxConstraints.maxWidth)
      //               ],
      //             )
      //           ],
      //         )
      //       : Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Image.asset(
      //               assetMap["tutCppLogo"]!,
      //               width: boxConstraints.maxWidth * 0.9,
      //               // height: boxConstraints.maxHeight * 0.5,
      //             ),
      //             Column(
      //               children: [
      //                 ...getAdContent(context, boxConstraints.maxWidth * 2)
      //               ],
      //             )
      //           ],
      //         ),
      // );
    });
  }
}
