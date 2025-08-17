import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDescription extends StatelessWidget {
  final double slideShowHeight, slideShowWidth;
  final String productImage, productName, productTagLine;
  final Widget content;
  const ProductDescription({
    super.key,
    required this.slideShowHeight,
    required this.slideShowWidth,
    required this.productImage,
    required this.productName,
    required this.content,
    required this.productTagLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: slideShowHeight,
      width: slideShowWidth,
      padding: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: (slideShowWidth < 500)
              ? Alignment.topCenter
              : Alignment.centerLeft,
          end: (slideShowWidth < 500)
              ? Alignment.bottomCenter
              : Alignment.centerRight,
          colors: [
            Theme.of(context).colorScheme.secondaryContainer,
            Theme.of(context).colorScheme.primaryContainer,
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) {
          return Center(
            child: (boxConstraints.maxWidth > 500)
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              productImage,
                              fit: BoxFit.cover,
                              width: boxConstraints.maxWidth * 0.25,
                            ),
                            Column(
                              children: [
                                Text(
                                  productName,
                                  style: GoogleFonts.protestGuerrilla(
                                    fontSize: boxConstraints.maxWidth * 0.03,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  productTagLine,
                                  style: GoogleFonts.prociono(
                                      fontSize: boxConstraints.maxWidth * 0.01,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: boxConstraints.maxWidth * 0.05,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withValues(
                                  alpha: 0.5,
                                ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: content,
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              productImage,
                              fit: BoxFit.cover,
                              width: boxConstraints.maxWidth * 0.40,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10),
                                  Column(
                                    children: [
                                      Text(
                                        productName,
                                        style: GoogleFonts.protestGuerrilla(
                                          fontSize:
                                              boxConstraints.maxWidth * 0.1,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        productTagLine,
                                        style: GoogleFonts.prociono(
                                            fontSize:
                                                boxConstraints.maxWidth * 0.04,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withValues(
                                  alpha: 0.5,
                                ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: content,
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
