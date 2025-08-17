import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:promaxbiz/utils/constants.dart';

class WebModel with ChangeNotifier {
  final BuildContext context;

  bool loaded = false;

  WebModel(this.context) {
    if (!loaded) {
      // await Future.delayed(const Duration(seconds: 5), () {});
    }
    loaded = true;
    notifyListeners();
  }

  Future<void> initialize() async {
    if (!loaded) {
      // await Future.delayed(const Duration(seconds: 5), () {});
    }
    loaded = true;
    notifyListeners();
  }

  Image getWebAppLogo(BuildContext context, double height, double width) {
    // double appWidth = MediaQuery.of(context).size.width;

    return Image(
      height: height,
      image: AssetImage(
        assetMap['appProMaxBizLogo']!,
      ),
      fit: BoxFit.fill,
      // height: 75,
    );
  }

  Column getWebAppTitle(BuildContext context, double height, double width) {
    // double appWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "PRO",
              style: GoogleFonts.protestGuerrilla(
                color: Colors.green,
                fontSize: height * 0.5,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "MAX",
              style: GoogleFonts.protestGuerrilla(
                color: Colors.yellow,
                fontSize: height * 0.5,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "BIZ",
              style: GoogleFonts.protestGuerrilla(
                color: Colors.pink,
                fontSize: height * 0.5,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          "Pro Ideas for Max Outcomes",
          style: GoogleFonts.prociono(
            color: Colors.amber,
            fontSize: height * 0.15,
            letterSpacing: 3,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  // List<Widget> getMenuOptions(BuildContext context) {
  //   return [
  //     TextButton(
  //       // onPressed: () => Navigator.pushNamedAndRemoveUntil(
  //       //   context,
  //       //   MyHomePage.name,
  //       //   ModalRoute.withName(
  //       //     Navigator.defaultRouteName,
  //       //   ),
  //       // ),
  //       onPressed: () => setCurrentMenu(widgetSlideShow),
  //       child: Text(
  //         "HOME",
  //         style: Theme.of(context).textTheme.titleSmall,
  //       ),
  //     ),
  //     TextButton(
  //       onPressed: () {
  //         setCurrentMenu(widgetAbout);
  //       },
  //       child: Text(
  //         "ABOUT",
  //         style: Theme.of(context).textTheme.titleSmall,
  //       ),
  //     ),
  //   ];
  // }
}
