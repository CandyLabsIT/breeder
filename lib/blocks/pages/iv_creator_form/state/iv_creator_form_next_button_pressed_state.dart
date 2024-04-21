import 'package:breeder/blocks/pages/iv_creator_form/a_iv_creator_form_state.dart';

class IVCreatorFormNextButtonPressedState extends AIVCreatorFormState {
  final int getNextView;

  const IVCreatorFormNextButtonPressedState({required this.getNextView});

  @override
  List<Object> get props => <Object>[getNextView];
}
