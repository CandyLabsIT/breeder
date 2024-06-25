import 'dart:ui';

import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';

class RestartedThirdGenerationMaleValuesState extends AThirdGenerationState {
  final List<Color> valuesList;

  const RestartedThirdGenerationMaleValuesState({required this.valuesList});

  @override
  List<List<Color>> get props => <List<Color>>[valuesList];
}
