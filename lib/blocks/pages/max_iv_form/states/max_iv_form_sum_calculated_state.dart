import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';

class MaxIVFormSumCalculatedState extends AMaxIVFormState {
  final int maxIVFormSum;

  const MaxIVFormSumCalculatedState({required this.maxIVFormSum});

  @override
  List<Object> get props => <Object>[maxIVFormSum];
}
