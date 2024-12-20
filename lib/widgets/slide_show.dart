import 'dart:async';

import 'package:flutter/material.dart';
import 'package:promaxbiz/utils/constants.dart';

class SlideShow extends StatefulWidget {
  final double slideShowHeight, slideShowWidth;
  const SlideShow({
    super.key,
    required this.slideShowHeight,
    required this.slideShowWidth,
  });

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  Timer? countdownTimer;
  int currentSlide = 0;
  bool pageInit = false, playingSlides = true;

  List<Widget> slides = [
    Container(
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: const Text("1 Green"),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.yellow,
      ),
      child: const Text("2 Yellow"),
    ),
    Container(
      decoration: const BoxDecoration(
        color: Colors.pink,
      ),
      child: const Text("3 Pink"),
    ),
  ];

  void incrementSlide() {
    setState(() {
      if (currentSlide < (slides.length - 1)) {
        currentSlide++;
      } else {
        currentSlide = 0;
      }
    });
  }

  void startTimer() {
    countdownTimer = Timer.periodic(
      const Duration(
        seconds: slideShowDuration,
      ),
      (_) => incrementSlide(),
    );
  }

  void stopTimer() {
    setState(() {
      if (countdownTimer != null) countdownTimer?.cancel();
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() => currentSlide = 0);
  }

  @override
  void dispose() {
    if (countdownTimer != null) countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (pageInit == false) {
      startTimer();
      pageInit = true;
    }
    // return SizedBox(
    //   height: widget.slideShowHeight,
    //   child: Column(
    //     children: [slides[currentSlide]],
    //   ),
    // );
    return SizedBox(
      height: widget.slideShowHeight,
      width: widget.slideShowWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: widget.slideShowHeight * 0.98,
                width: double.infinity,
                child: slides[currentSlide],
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: FloatingActionButton(
                  onPressed: () {
                    if (playingSlides) {
                      stopTimer();
                    } else {
                      startTimer();
                    }

                    playingSlides = !playingSlides;
                  },
                  child: Icon(
                    playingSlides ? Icons.play_arrow : Icons.pause,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: widget.slideShowHeight * 0.02,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: slides.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => setState(() {
                    currentSlide = index;
                  }),
                  child: Row(
                    children: [
                      Container(
                        width: (index == currentSlide)
                            ? widget.slideShowWidth * 0.1
                            : widget.slideShowWidth * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      SizedBox(
                        width: widget.slideShowWidth * 0.02,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
