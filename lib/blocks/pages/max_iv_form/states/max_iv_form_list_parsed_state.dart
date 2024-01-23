import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';

class MaxIVFormListParsedState extends AMaxIVFormState{
  final List<int> maxIVList;

  const MaxIVFormListParsedState({required this.maxIVList});

  @override
  List<Object> get props => <Object>[maxIVList];
}