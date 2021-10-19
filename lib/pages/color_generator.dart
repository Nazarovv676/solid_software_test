import 'dart:math';

import 'package:flutter/material.dart';

class ColorGenerator {
  // seed increases randomization
  final pseudoRandomizer = Random(DateTime.now().microsecond);

  Color nextColor() {
    final nextValue = (pseudoRandomizer.nextDouble() * 0xFFFFFF).toInt();
    return Color(nextValue).withOpacity(1.0);
  }
}
