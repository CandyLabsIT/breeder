import 'package:breeder/blocks/pages/third_generation/a_third_generation_state.dart';
import 'package:flutter/cupertino.dart';

class DisplayedThirdGenerationWidgetState extends AThirdGenerationState{
  final Widget thirdGenerationWidget;

  const DisplayedThirdGenerationWidgetState({required this.thirdGenerationWidget});

  @override
  List<Widget> get props => <Widget>[thirdGenerationWidget];
}