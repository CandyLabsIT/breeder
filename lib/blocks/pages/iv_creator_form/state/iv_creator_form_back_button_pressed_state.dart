import 'package:breeder/blocks/pages/iv_creator_form/a_iv_creator_form_state.dart';
import 'package:flutter/cupertino.dart';

class IVCreatorFormBackButtonPressedState extends AIVCreatorFormState{
  final Widget backView;

  const IVCreatorFormBackButtonPressedState({required this.backView});

  @override
  List<Widget> get props => <Widget>[backView];
}