import 'package:breeder/blocks/pages/iv_creator_form/a_iv_creator_form_state.dart';
import 'package:flutter/cupertino.dart';

class IVCreatorFormNextButtonPressedState extends AIVCreatorFormState{
  final Widget nextView;
  
  const IVCreatorFormNextButtonPressedState({required this.nextView});
  
  @override
  List<Widget> get props => <Widget>[nextView];
}