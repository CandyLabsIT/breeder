import 'package:breeder/blocks/pages/single_iv_form/a_single_iv_form_state.dart';
import 'package:breeder/blocks/pages/single_iv_form/states/single_iv_form_init_state.dart';
import 'package:breeder/blocks/pages/single_iv_form/states/single_iv_form_sum_calulated_state.dart';
import 'package:breeder/shared/models/single_iv_form/single_iv_form_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleIVFormCubit extends Cubit<ASingleIVFormState> {
  late SingleIVFormModel singleIVFormModel = SingleIVFormModel();

  SingleIVFormCubit() : super(SingleIVFormInitState());

  void calculateSum() {
    emit(SingleIVFormSumCalculatedState(singleIVFormSum: singleIVFormModel.calculateSum()));
  }
}
