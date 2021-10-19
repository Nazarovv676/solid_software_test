import 'dart:async';

import 'package:flutter/material.dart';
import 'package:solid_software_test/pages/main/color_generator.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _colorGenerator = ColorGenerator();

  late Color _color = _colorGenerator.nextColor();

  final _animDuration = const Duration(seconds: 1);
  final _animCurve = Curves.ease;
  late Timer _timer;

  bool _showHelpLabel = false;

  @override
  void initState() {
    super.initState();
    _timer = _newTimer;
  }

  Timer get _newTimer => Timer(
        const Duration(seconds: 5),
        () => setState(() {
          _showHelpLabel = true;
        }),
      );

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      curve: _animCurve,
      tween: ColorTween(begin: _color, end: _color),
      duration: _animDuration,
      builder: (context, animatedColor, _) {
        return Material(
          color: animatedColor,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () => setState(() {
              _color = _colorGenerator.nextColor();
              _showHelpLabel = false;
              _timer.cancel();
              _timer = _newTimer;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  duration: _animDuration,
                  curve: _animCurve,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: _textColor),
                  child: const Text('Hey there'),
                ),
                const SizedBox(height: 20),
                IgnorePointer(
                  child: AnimatedOpacity(
                    opacity: _showHelpLabel ? 1 : 0,
                    duration: _animDuration,
                    curve: _animCurve,
                    child: AnimatedDefaultTextStyle(
                      duration: _animDuration,
                      curve: _animCurve,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: _textColor),
                      child: const Text('Tap to change color'),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Color get _textColor {
    final grayscale =
        (0.299 * _color.red) + (0.587 * _color.green) + (0.114 * _color.blue);
    if (grayscale > 128) {
      // background color is light
      return Colors.black;
    } else {
      // background color is dark
      return Colors.white;
    }
  }
}
