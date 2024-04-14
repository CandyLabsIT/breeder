import 'package:breeder/blocks/pages/single_iv_form/a_single_iv_form_state.dart';

class SingleIVFormSumCalculatedState extends ASingleIVFormState {
  final int singleIVFormSum;

  const SingleIVFormSumCalculatedState({required this.singleIVFormSum});

  @override
  List<Object> get props => <Object>[singleIVFormSum];
}
