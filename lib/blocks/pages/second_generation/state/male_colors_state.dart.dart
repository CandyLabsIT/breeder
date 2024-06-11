import 'package:breeder/blocks/pages/second_generation/a_second_generation_cubit.dart';
import 'package:flutter/animation.dart';

class MaleColorsState extends ASecondGenerationState {
  final List<Color> valuesList;

  const MaleColorsState({required this.valuesList});

  @override
  List<List<Color>> get props => <List<Color>>[valuesList];
}