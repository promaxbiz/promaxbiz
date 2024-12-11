import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:promaxbiz/utils/constants.dart';
// import 'package:promaxbiz/components/menu_options.dart';

class AppDrawer extends StatelessWidget {
  final double appWidth, appHeight;
  final WebModel webModel;
  final Function switchScreen;
  const AppDrawer({
    super.key,
    required this.appWidth,
    required this.appHeight,
    required this.webModel,
    required this.switchScreen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: appWidth * 0.3,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                assetMap["appBarBackground"]!,
              ),
              fit: BoxFit.none,
            ),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DrawerHeader(
                child: webModel.getWebAppLogo(context),
              ),
              // ...webModel.getMenuOptions(context),
              TextButton(
                // onPressed: () => Navigator.pushNamedAndRemoveUntil(
                //   context,
                //   MyHomePage.name,
                //   ModalRoute.withName(
                //     Navigator.defaultRouteName,
                //   ),
                // ),
                onPressed: () => switchScreen(widgetSlideShow),
                child: Text(
                  "HOME",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              TextButton(
                onPressed: () => switchScreen(widgetAbout),
                child: Text(
                  "CONTACT",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
