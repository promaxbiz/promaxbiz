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

  getWebAppLogo(BuildContext context) {
    // double appWidth = MediaQuery.of(context).size.width;

    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.amber,
      child: Image(
        image: AssetImage(
          assetMap['appProMaxBizLogo']!,
        ),
        fit: BoxFit.fill,
        // height: 75,
      ),
    );
  }

  getWebAppTitle(BuildContext context) {
    // double appWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            Text(
              "PRO",
              style: GoogleFonts.protestGuerrilla(
                color: Colors.green,
                fontSize: 30,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "MAX",
              style: GoogleFonts.protestGuerrilla(
                color: Colors.yellow,
                fontSize: 30,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "BIZ",
              style: GoogleFonts.protestGuerrilla(
                color: Colors.pink,
                fontSize: 30,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          "Pro Ideas for Max Outcomes",
          style: GoogleFonts.prociono(
            // color: Colors.amber,
            fontSize: 10,
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
