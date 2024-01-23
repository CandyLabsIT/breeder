import 'package:breeder/blocks/pages/max_iv_form/a_max_iv_form_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_init_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_list_parsed_state.dart';
import 'package:breeder/blocks/pages/max_iv_form/states/max_iv_form_sum_calculated_state.dart';
import 'package:breeder/shared/models/max_iv_form/max_iv_form_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaxIVFormCubit extends Cubit<AMaxIVFormState> {
  late MaxIVFormModel maxIVFormModel = MaxIVFormModel();

  MaxIVFormCubit() : super(MaxIVFormInitState());

  void calculateSum() {
    emit(MaxIVFormSumCalculatedState(maxIVFormSum: maxIVFormModel.calculateWeightedSum()));
  }

  void getListAmount(){
    emit(MaxIVFormListParsedState(maxIVList: maxIVFormModel.getAmountList()));
  }
}
