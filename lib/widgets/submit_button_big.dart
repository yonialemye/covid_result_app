import 'package:flutter/material.dart';

class SubmitButtonBig extends StatelessWidget {
  const SubmitButtonBig({Key? key, this.gradient, this.color, required this.text, this.onTap})
      : super(key: key);

  final LinearGradient? gradient;
  final Color? color;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
        gradient: gradient,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            letterSpacing: 1,
            fontFamily: 'Bold',
          ),
        ),
      ),
    );
  }
}
