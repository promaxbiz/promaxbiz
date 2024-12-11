import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:promaxbiz/widgets/contact_us.dart';
import 'package:promaxbiz/widgets/app_drawer.dart';
import 'package:promaxbiz/widgets/footer.dart';
import 'package:promaxbiz/widgets/slide_show.dart';
import 'package:promaxbiz/widgets/web_menu_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static const String name = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool initPage = false;
  late WebModel webModel;
  late double appHeight, appWidth;
  String currentWidgetToShow = widgetSlideShow;
  void switchScreen(String screenName) {
    setState(() {
      currentWidgetToShow = screenName;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initPage) {
      webModel = WebModel(context);

      initPage = true;
    }

    appHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top -
        MediaQuery.of(context).viewPadding.bottom;

    appWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: (appWidth > 600)
          ? null
          : AppDrawer(
              appHeight: appHeight,
              appWidth: appWidth,
              webModel: webModel,
              switchScreen: switchScreen,
            ),
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage(
            assetMap["appBarBackground"]!,
          ),
          fit: BoxFit.none,
        ),
        toolbarHeight: appHeight * 0.10,
        title: WebMenuBar(
          webModel: webModel,
          switchScreen: switchScreen,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.blueGrey.shade100,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(
        //       assetMap["appBarBackground"]!,
        //     ),
        //     fit: BoxFit.none,
        //   ),
        // ),

        // child: CustomScrollView(
        //   slivers: [
        //     SliverList.list(
        //       children: [
        //         if (currentWidgetToShow == widgetSlideShow)
        //           SlideShow(
        //             slideShowHeight: appHeight * 0.7,
        //             slideShowWidth: appWidth,
        //           )
        //         else
        //           Contact(
        //             slideShowHeight: appHeight * 0.7,
        //             slideShowWidth: appWidth,
        //           ),
        //       ],
        //     ),
        //     // SliverFillRemaining(
        //     //   hasScrollBody: false,
        //     //   child: MaxWidthBox(
        //     //       maxWidth: 1200,
        //     //       backgroundColor: Colors.white,
        //     //       child: Container()),
        //     // ),
        //   ],
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentWidgetToShow == widgetSlideShow)
              SlideShow(
                slideShowHeight: appHeight * 0.8,
                slideShowWidth: appWidth,
              )
            else
              Contact(
                slideShowHeight: appHeight * 0.8,
                slideShowWidth: appWidth,
              ),
            Footer(
              footerHeight: appHeight * 0.1,
              footerWidth: appWidth,
            ),
          ],
        ),
      ),
    );
  }
}
