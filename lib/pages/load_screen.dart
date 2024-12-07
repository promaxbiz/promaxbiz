import 'package:flutter/material.dart';
import 'package:promaxbiz/utils/constants.dart';

class LoadScreen extends StatelessWidget {
  static String name = "/load_screen";
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Loading Screen",
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image(
                            image: AssetImage(assetMap['appProMaxBizLogo']!),
                            fit: BoxFit.fill,
                            // height: appHeight * 0.5,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Loading the",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                "PRO MAX BIZ",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const CircularProgressIndicator(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
