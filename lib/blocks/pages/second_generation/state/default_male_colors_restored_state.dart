import 'dart:ui';

import 'package:breeder/blocks/pages/second_generation/a_second_generation_state.dart';

class DefaultMaleColorsRestoredState extends ASecondGenerationState {
  final List<Color> valuesList;

  const DefaultMaleColorsRestoredState({required this.valuesList});

  @override
  List<List<Color>> get props => <List<Color>>[valuesList];
}
