import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:provider/provider.dart';
// import 'package:promaxbiz/components/menu_options.dart';

class AppDrawer extends StatelessWidget {
  final double appWidth, appHeight;
  const AppDrawer({
    super.key,
    required this.appWidth,
    required this.appHeight,
  });

  @override
  Widget build(BuildContext context) {
    WebModel webModel = Provider.of<WebModel>(context, listen: true);
    return SizedBox(
      width: appWidth * 0.3,
      child: Drawer(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DrawerHeader(
              child: webModel.getWebAppLogo(context),
            ),
            ...webModel.getMenuOptions(context),
          ],
        ),
      ),
    );
  }
}
