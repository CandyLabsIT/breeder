import 'dart:ui';

import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';

class SecondGenMaleColorsDefaultState extends ASecondGenState {
  final List<Color> colorsList;

  const SecondGenMaleColorsDefaultState({required this.colorsList});

  @override
  List<List<Color>> get props => <List<Color>>[colorsList];
}
