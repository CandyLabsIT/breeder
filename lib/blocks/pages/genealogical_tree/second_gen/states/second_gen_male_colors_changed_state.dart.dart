import 'package:breeder/blocks/pages/genealogical_tree/second_gen/a_second_gen_state.dart';
import 'package:flutter/animation.dart';

class SecondGenMaleColorsChangedState extends ASecondGenState {
  final List<Color> colorsList;

  const SecondGenMaleColorsChangedState({required this.colorsList});

  @override
  List<List<Color>> get props => <List<Color>>[colorsList];
}