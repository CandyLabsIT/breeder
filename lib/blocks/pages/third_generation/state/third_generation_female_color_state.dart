import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:flutter/animation.dart';

class ThirdGenerationFemaleColorsState extends AThirdGenerationState {
  final List<Color> valuesList;

  const ThirdGenerationFemaleColorsState({required this.valuesList});

  @override
  List<List<Color>> get props => <List<Color>>[valuesList];
}
