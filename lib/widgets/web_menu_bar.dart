import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:promaxbiz/utils/common_logic.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:promaxbiz/utils/menu_options.dart';
import 'package:promaxbiz/widgets/image_icon_label.dart';

/// Menu/Navigation Bar
///
/// A top menu bar with a text or image logo and
/// navigation links. Navigation links collapse into
/// a hamburger menu on screens smaller than 400px.

class WebMenuBar extends StatefulWidget {
  final double menuBarHeight, menuBarWidth;
  final WebModel webModel;

  final Function switchScreen;
  const WebMenuBar({
    super.key,
    required this.webModel,
    required this.switchScreen,
    required this.menuBarHeight,
    required this.menuBarWidth,
  });

  @override
  State<WebMenuBar> createState() => _WebMenuBarState();
}

class _WebMenuBarState extends State<WebMenuBar> {
  // Function to handle the navigation based on the selected option.
  // Future<void> handleMenuSelection(
  //     BuildContext context, MenuOptions value) async {
  //   switch (value) {
  //     case MenuOptions.addEditChain:
  //       NavigatorState nav = Navigator.of(context);
  //       ChainList chainList = Provider.of<ChainList>(
  //         context,
  //         listen: false,
  //       );
  //       FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.custom,
  //         allowedExtensions: ["json"],
  //       );

  //       if (result != null) {
  //         Chain? chain = await chainList.uploadChain(
  //           String.fromCharCodes(result.files.single.bytes!),
  //         );
  //         if (chain != null) {
  //           chain.edit = true;
  //           await nav.pushNamed(
  //             AddChainScreen.routename,
  //             arguments: chain,
  //           );
  //         }
  //       } else {
  //         // User canceled the picker
  //       }

  //       break;
  //     case MenuOptions.createNewChain:
  //       Navigator.of(
  //         context,
  //       ).pushReplacementNamed(AddChainScreen.routename);
  //       break;
  //     case MenuOptions.playChain:
  //       Navigator.of(context).pushReplacementNamed("/");
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // double appHeight = MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).viewPadding.top -
    //     MediaQuery.of(context).viewPadding.bottom;

    double appWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: widget.menuBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: InkWell(
              onTap: () => widget.switchScreen(widgetSlideShow),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (appWidth > 200)
                    widget.webModel.getWebAppLogo(
                      context,
                      widget.menuBarHeight,
                      widget.menuBarWidth,
                    ),
                  if (appWidth > 350)
                    widget.webModel.getWebAppTitle(
                      context,
                      widget.menuBarHeight,
                      widget.menuBarWidth,
                    ),
                  // webModel.getWebAppLogo(context),
                  // webModel.getWebAppTitle(context),
                ],
              ),
            ),
          ),
          if (appWidth > 600)
            Row(
              children: [
                //...webModel.getMenuOptions(context),
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
                  tooltip: "CHAINPLAY\nWeb Application",
                  // The main menu button widget.
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(colors: [
                        Colors.amber,
                        Colors.grey,
                      ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ImageIconLabel(
                      imageUrl: assetMap["appChainPlayLogo"]!,
                      label: "",
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => widget.switchScreen(widgetAbout),
                  child: ImageIconLabel(
                    imageUrl: assetMap["appProMaxBizLogo"]!,
                    label: "Contact",
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
