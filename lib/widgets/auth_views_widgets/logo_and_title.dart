import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:covid_result_app/utils/colors.dart';
import 'package:flutter/material.dart';

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({Key? key, this.haveAnimation = true}) : super(key: key);

  final bool haveAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 80,
          ),
          const SizedBox(width: 10),
          haveAnimation
              ? AnimatedTextKit(
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'Covid Result\nChecker',
                      textStyle: const TextStyle(
                        fontFamily: 'Black',
                        fontSize: 26,
                        letterSpacing: 1,
                      ),
                      colors: [
                        Colors.grey[700]!,
                        mainColor,
                        secondaryColor,
                      ],
                      textAlign: TextAlign.center,
                    ),
                  ],
                  isRepeatingAnimation: false,
                )
              : Text(
                  'Covid Result\nChecker',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Black',
                    fontSize: 26,
                    letterSpacing: 1,
                    color: Colors.grey[700],
                  ),
                ),
        ],
      ),
    );
  }
}
