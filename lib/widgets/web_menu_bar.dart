import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:promaxbiz/utils/constants.dart';

/// Menu/Navigation Bar
///
/// A top menu bar with a text or image logo and
/// navigation links. Navigation links collapse into
/// a hamburger menu on screens smaller than 400px.

class WebMenuBar extends StatefulWidget {
  final WebModel webModel;

  final Function switchScreen;
  const WebMenuBar(
      {super.key, required this.webModel, required this.switchScreen});

  @override
  State<WebMenuBar> createState() => _WebMenuBarState();
}

class _WebMenuBarState extends State<WebMenuBar> {
  @override
  Widget build(BuildContext context) {
    // double appHeight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).viewPadding.top -
    //     MediaQuery.of(context).viewPadding.bottom;

    double appWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (appWidth > 200) widget.webModel.getWebAppLogo(context),
            if (appWidth > 600) widget.webModel.getWebAppTitle(context),
            // webModel.getWebAppLogo(context),
            // webModel.getWebAppTitle(context),
          ],
        ),
        if (appWidth > 600)
          Container(
            alignment: Alignment.centerRight,
            child: Wrap(
              children: [
                //...webModel.getMenuOptions(context),
                TextButton(
                  // onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  //   context,
                  //   MyHomePage.name,
                  //   ModalRoute.withName(
                  //     Navigator.defaultRouteName,
                  //   ),
                  // ),
                  onPressed: () => widget.switchScreen(widgetSlideShow),
                  child: Text(
                    "HOME",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                TextButton(
                  onPressed: () => widget.switchScreen(widgetAbout),
                  child: Text(
                    "CONTACT",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
