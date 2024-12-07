import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:promaxbiz/utils/constants.dart';
import 'package:promaxbiz/widgets/app_drawer.dart';
import 'package:promaxbiz/widgets/footer.dart';
import 'package:promaxbiz/widgets/slide_show.dart';
import 'package:promaxbiz/widgets/web_menu_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static const String name = '/home';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    WebModel webModel = Provider.of<WebModel>(context, listen: true);
    double appHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.top -
        MediaQuery.of(context).viewPadding.bottom;

    double appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: (ResponsiveBreakpoints.of(context).isDesktop)
          ? null
          : AppDrawer(
              appHeight: appHeight,
              appWidth: appWidth,
            ),
      appBar: AppBar(
        toolbarHeight: appHeight * 0.15,
        title: const WebMenuBar(),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.list(
            children: [
              if (webModel.currentWidgetToShow == widgetSlideShow)
                SlideShow(
                  slideShowHeight: appHeight * 0.8,
                  slideShowWidth: appWidth,
                )
              else
                const Text("About PromaxBiz"),
              const Divider(),
              const Footer(),
            ],
          ),
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: MaxWidthBox(
          //       maxWidth: 1200,
          //       backgroundColor: Colors.white,
          //       child: Container()),
          // ),
        ],
      ),
    );
  }
}
