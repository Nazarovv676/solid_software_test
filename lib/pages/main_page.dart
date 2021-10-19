import 'package:flutter/material.dart';
import 'package:solid_software_test/pages/color_generator.dart';

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
            }),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: _animDuration,
                curve: _animCurve,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: _textColor),
                child: const Text('Hey there'),
              ),
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
