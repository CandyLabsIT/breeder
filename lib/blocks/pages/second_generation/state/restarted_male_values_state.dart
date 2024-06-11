import 'dart:ui';

import 'package:breeder/blocks/pages/second_generation/a_second_generation_cubit.dart';

class RestartedMaleValuesState extends ASecondGenerationState {
  final List<Color> valuesList;

  const RestartedMaleValuesState({required this.valuesList});

  @override
  List<List<Color>> get props => <List<Color>>[valuesList];
}
