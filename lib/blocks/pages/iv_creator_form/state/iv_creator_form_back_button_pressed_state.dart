import 'package:breeder/blocks/pages/iv_creator_form/a_iv_creator_form_state.dart';

class IVCreatorFormBackButtonPressedState extends AIVCreatorFormState {
  final int getPreviousView;

  const IVCreatorFormBackButtonPressedState({required this.getPreviousView});

  @override
  List<int> get props => <int>[getPreviousView];
}
