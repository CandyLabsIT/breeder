import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';
import 'package:flutter/animation.dart';

class IVChangedFemaleColorsState extends ASecondGenerationState {
  final List<Color> valuesList;

  const IVChangedFemaleColorsState({required this.valuesList});

  @override
  List<List<Color>> get props => <List<Color>>[valuesList];
}
