import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_med/core/providers/app_state_data_provider.dart';

class MathMedButton extends ConsumerWidget {

  final String text;
  final VoidCallback function;
  final bool primaryButton;
  final bool colourFollowsOperator;
  final String textFontFamily;
  final double textSize;
  final FontWeight fontWeight;
  final Size buttonSize;

  const MathMedButton({
    super.key,
    required this.text,
    required this.function,
    this.primaryButton = false,
    this.colourFollowsOperator = true,
    this.textSize = 20,
    this.textFontFamily = "IBM Plex Sans Thai",
    this.fontWeight = const FontWeight(100),
    this.buttonSize = const Size(150,50),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color colour;

    if (primaryButton) {
      colour = Theme.of(context).colorScheme.primary;
    } else if (colourFollowsOperator) {
      colour = ref.read(appStateDataProvider).selectedOperator.colour;
    } else {
      colour = Theme.of(context).colorScheme.surface;
    }

    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: colour,
        foregroundColor: Colors.white,
        fixedSize: buttonSize,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
          fontFamily: textFontFamily,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}