import 'package:breeder/blocks/pages/max_iv_slots_creator_page/a_max_iv_slots_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_amount_change_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_initial_state.dart';
import 'package:breeder/blocks/pages/max_iv_slots_creator_page/states/max_iv_slots_sum_changed_state.dart';
import 'package:breeder/shared/models/max_iv_slots_amount_model/max_iv_slots_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaxIVSlotsCubit extends Cubit<AMaxIVSlotsState> {
  final MaxIVSlotsModel maxIVSlotsModel = MaxIVSlotsModel();

  MaxIVSlotsCubit() : super(MaxIVSlotsInitialState());

  void calculateMaxIVSlotsSum() {
    emit(MaxIVSlotsSumChangedState(maxIVSlotsSum: maxIVSlotsModel.calculateMaxIVSlotsSum()));
  }

  void maxIVSlotsAmountList() {
    emit(MaxIVSlotsAmountChangedState(maxIVSlotsAmountList: maxIVSlotsModel.getMaxIVSlotsAmountList()));
  }
}
