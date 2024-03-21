import 'package:breeder/blocks/pages/max_iv_slots_page/a_iv_slots_amount_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/states/iv_slots_amount_initial_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/states/iv_slots_amount_list.dart';
import 'package:breeder/blocks/pages/max_iv_slots_page/states/iv_slots_sum_state.dart';
import 'package:breeder/shared/models/iv_slots_amount_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IVSlotsAmountCubit extends Cubit<AIVTextFormsState> {
  final IVSlotsAmountModel ivSlotsAmountModel = IVSlotsAmountModel();

  IVSlotsAmountCubit() : super(IVSlotsAmountInitial());

  void ivSlotsSum() {
    emit(IVTextFormValueChangedState(textFormsSum: ivSlotsAmountModel.calculateSlotsSum()));
  }

  void ivSlotsAmountList() {
    emit(IVSlotsAmountListState(slotsList: ivSlotsAmountModel.getAmountList()));
  }

  void updateTextFormValue(int index, String value) {
    ivSlotsAmountModel.updateTextFormValue(index, value);
  }
}
