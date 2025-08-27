import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:promaxbiz/utils/common_logic.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:promaxbiz/utils/menu_options.dart';
import 'package:promaxbiz/widgets/image_icon_label.dart';
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
      width: appWidth * 0.5,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DrawerHeader(
                child: InkWell(
                  onTap: () => switchScreen(widgetSlideShow),
                  child: webModel.getWebAppLogo(
                    context,
                    appHeight,
                    appWidth,
                  ),
                ),
              ),
              // ...webModel.getMenuOptions(context),
              TextButton(
                onPressed: () => switchScreen(widgetAbout),
                child: ImageIconLabel(
                  imageUrl: assetMap["appProMaxBizLogo"]!,
                  label: "CONTACT",
                ),
              ),
              PopupMenuButton<MenuOptions>(
                onSelected: (value) =>
                    CommonLogic().handleMenuSelection(context, value),
                color: Theme.of(context).primaryColor,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<MenuOptions>>[
                    // The sub-menu options.
                    const PopupMenuItem<MenuOptions>(
                      value: MenuOptions.addEditChain,
                      child: Text('Upload & Edit Chain'),
                    ),
                    const PopupMenuItem<MenuOptions>(
                      value: MenuOptions.createNewChain,
                      child: Text('Create a New Chain'),
                    ),
                    // const PopupMenuItem<MenuOptions>(
                    //   value: MenuOptions.playChain,
                    //   child: Text('Play a Chain'),
                    // ),
                  ];
                },
                // The main menu button widget.
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ImageIconLabel(
                    imageUrl: assetMap["appChainPlayLogo"]!,
                    label: "CHAINPLAY",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
