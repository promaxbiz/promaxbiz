import 'package:flutter/material.dart';
import 'package:promaxbiz/model/web_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Menu/Navigation Bar
///
/// A top menu bar with a text or image logo and
/// navigation links. Navigation links collapse into
/// a hamburger menu on screens smaller than 400px.

class WebMenuBar extends StatelessWidget {
  const WebMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    WebModel webModel = Provider.of<WebModel>(context, listen: true);
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (ResponsiveBreakpoints.of(context).screenWidth > 200)
                webModel.getWebAppLogo(context),
              if (ResponsiveBreakpoints.of(context).isDesktop ||
                  ResponsiveBreakpoints.of(context).isTablet)
                webModel.getWebAppTitle(context),
            ],
          ),
          if (ResponsiveBreakpoints.of(context).isDesktop)
            Container(
              alignment: Alignment.centerRight,
              child: Wrap(
                children: [
                  ...webModel.getMenuOptions(context),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
