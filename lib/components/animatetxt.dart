// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:animated_text_kit/animated_text_kit.dart';

Widget animateTxt(String text , func) {
  return AnimatedTextKit(
    animatedTexts: [
      TyperAnimatedText(text),
    ],
    onTap: func,
  );
}
