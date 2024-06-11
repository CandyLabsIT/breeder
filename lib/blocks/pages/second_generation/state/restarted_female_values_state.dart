import 'dart:ui';

import 'package:breeder/blocks/pages/second_generation/a_second_generation_cubit.dart';

class RestartedFemaleValuesState extends ASecondGenerationState {
  final List<Color> valuesList;

  const RestartedFemaleValuesState({required this.valuesList});

  @override
  List<List<Color>> get props => <List<Color>>[valuesList];
}
